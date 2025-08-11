provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

resource "random_string" "suffix" {
  length = 8
  lower = true
  upper = false
  numeric = false
  special = false
}

locals {
  common_name = random_string.suffix.id
}

resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "vpc-${local.common_name}"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = "vswitch-${local.common_name}"
}

resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg-${local.common_name}"
}

data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_x64_20G_alibase_.*"
  most_recent = true
  owners      = "system"
}

resource "alicloud_ram_user" "ram_user" {
  name = "create_by_solution-${local.common_name}"
}

resource "alicloud_ram_access_key" "ramak" {
  user_name = alicloud_ram_user.ram_user.name
  depends_on = [
    alicloud_ram_user.ram_user
  ]
}

resource "alicloud_ram_user_policy_attachment" "attach_policy_to_user" {
  user_name   = alicloud_ram_user.ram_user.name
  policy_type = "System"
  policy_name = "AliyunLogFullAccess"
  depends_on = [
    alicloud_ram_access_key.ramak
  ]
}

# the ECS instance which generate the log, and where LoongCollector is installed
resource "alicloud_instance" "ecs_instance" {
  instance_name              = "ecs-${local.common_name}"
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.vswitch.id
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = 5
}

resource "alicloud_ecs_command" "run_command" {
  name = "command-genlog-loongcollector-${local.common_name}"
  command_content = base64encode(<<EOF
cat << EOT >> ~/.bash_profile
export ROS_DEPLOY=true
export ALIBABA_CLOUD_ACCESS_KEY_ID=${alicloud_ram_access_key.ramak.id}
export ALIBABA_CLOUD_ACCESS_KEY_SECRET=${alicloud_ram_access_key.ramak.secret}
EOT

source ~/.bash_profile
curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/tech-solution/install-log-monitoring-alarming-0.1.sh|bash
wget http://aliyun-observability-release-${var.region}.oss-${var.region}.aliyuncs.com/loongcollector/linux64/latest/loongcollector.sh -O loongcollector.sh
chmod +x loongcollector.sh
./loongcollector.sh install ${var.region}-internet
EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
}

resource "alicloud_ecs_invocation" "invoke_script" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.run_command.id
  timeouts {
    create = "15m"
  }
  depends_on = [ alicloud_instance.ecs_instance ]
}

resource "alicloud_log_project" "sls_project" {
  project_name = "sls-project-${local.common_name}"
}

resource "alicloud_log_store" "sls_log_store" {
  logstore_name = "sls-logstore-${local.common_name}"
  project_name  = alicloud_log_project.sls_project.project_name
  depends_on = [ alicloud_log_project.sls_project ]
}

resource "alicloud_log_machine_group" "this" {
  identify_list = [alicloud_instance.ecs_instance.primary_ip_address]
  name          = "lmg-${local.common_name}"
  project       = alicloud_log_project.sls_project.project_name
  identify_type = "ip"
}

resource "alicloud_logtail_config" "this" {
  project      = alicloud_log_project.sls_project.project_name
  input_detail = <<EOF
{
  "discardUnmatch": false,
  "enableRawLog": true,
  "fileEncoding": "utf8",
  "filePattern": "sls-monitor-test.log",
  "logPath": "/tmp",
  "logType": "common_reg_log",
  "maxDepth": 10,
  "topicFormat": "none"
}
EOF
  input_type   = "file"
  logstore     = alicloud_log_store.sls_log_store.logstore_name
  name         = "lc-${local.common_name}"
  output_type  = "LogService"
}

resource "alicloud_logtail_attachment" "this" {
  project             = alicloud_log_project.sls_project.project_name
  logtail_config_name = alicloud_logtail_config.this.name
  machine_group_name  = alicloud_log_machine_group.this.name
}

resource "alicloud_log_store_index" "sls_index" {
  project  = alicloud_log_project.sls_project.project_name
  logstore = alicloud_log_store.sls_log_store.logstore_name
  full_text {}
  field_search {
    name = "content"
    type = "text"
  }
}

resource "alicloud_security_group" "security_group_kibana" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg-kibana-${local.common_name}"
}

resource "alicloud_security_group_rule" "allow_kibana" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "5601/5601"
  priority          = 1
  security_group_id = alicloud_security_group.security_group_kibana.id
  cidr_ip           = "0.0.0.0/0"
}

# the ECS instance where Kibana is deployed
resource "alicloud_instance" "ecs_instance_kibana" {
  instance_name              = "ecs-kibana-${local.common_name}"
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.instance_type_xlarge
  system_disk_category       = "cloud_essd"
  security_groups            = [alicloud_security_group.security_group_kibana.id]
  vswitch_id                 = alicloud_vswitch.vswitch.id
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = 10
}

resource "alicloud_ecs_command" "run_command_kibana" {
  name = "command-kibana-${local.common_name}"
  command_content = base64encode(<<EOF
cat << EOT >> ~/.bash_profile
export ROS_DEPLOY=true
export ALIBABA_CLOUD_ACCESS_KEY_ID=${alicloud_ram_access_key.ramak.id}
export ALIBABA_CLOUD_ACCESS_KEY_SECRET=${alicloud_ram_access_key.ramak.secret}
EOT

source ~/.bash_profile

# 安装Docker
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum -y install docker-ce
docker --version
systemctl start docker
systemctl enable docker

# 创建项目路径和用于存放数据的目录
mkdir sls-kibana
cd sls-kibana
mkdir data
chmod 777 data

# 在项目路径下创建.env文件
cat << EOJ >> .env
ES_PASSWORD=${var.ecs_instance_password}
SLS_ENDPOINT=${var.region}.log.aliyuncs.com
SLS_PROJECT=${alicloud_log_project.sls_project.project_name}
# 需要提前创建RAM用户，且需要为RAM用户授予Logstore的查询权限
# ECS RAM角色，请参见：https://help.aliyun.com/zh/ecs/user-guide/attach-an-instance-ram-role-to-an-ecs-instance
# ECS RAM角色授权，请参见：https://help.aliyun.com/zh/sls/compatibility-between-log-service-and-elasticsearch#de61167fc0lqi
SLS_ACCESS_KEY_ID=${alicloud_ram_access_key.ramak.id}
SLS_ACCESS_KEY_SECRET=${alicloud_ram_access_key.ramak.secret}
EOJ

# 在项目路径下创建docker-compose.yaml文件
cat << EOK >> docker-compose.yaml
services:
  es:
    image: sls-registry.cn-hangzhou.cr.aliyuncs.com/kproxy/elasticsearch:7.17.26
    environment:
      - "discovery.type=single-node"
      - "ES_JAVA_OPTS=-Xms2G -Xmx2G"
      - ELASTIC_USERNAME=elastic
      - ELASTIC_PASSWORD=${var.ecs_instance_password}
      - xpack.security.enabled=true
    volumes:
      - ./data:/usr/share/elasticsearch/data
  kproxy:
    image: sls-registry.cn-hangzhou.cr.aliyuncs.com/kproxy/kproxy:2.1.4
    depends_on:
      - es
    environment:
      - ES_ENDPOINT=es:9200
      - SLS_ENDPOINT=${var.region}.log.aliyuncs.com
      - SLS_PROJECT=${alicloud_log_project.sls_project.project_name}
      - SLS_ACCESS_KEY_ID=${alicloud_ram_access_key.ramak.id}
      - SLS_ACCESS_KEY_SECRET=${alicloud_ram_access_key.ramak.secret}
  kibana:
    image: sls-registry.cn-hangzhou.cr.aliyuncs.com/kproxy/kibana:7.17.26
    depends_on:
      - kproxy
    environment:
      - ELASTICSEARCH_HOSTS=http://kproxy:9201
      - ELASTICSEARCH_USERNAME=elastic
      - ELASTICSEARCH_PASSWORD=${var.ecs_instance_password}
      - XPACK_MONITORING_UI_CONTAINER_ELASTICSEARCH_ENABLED=true
    ports:
      - "5601:5601"
  # 这个服务组件是可选的，作用是自动创建kibana index pattern
  index-patterner:
    image: sls-registry.cn-hangzhou.cr.aliyuncs.com/kproxy/kproxy:2.1.4
    command: /usr/bin/python3 -u /workspace/create_index_pattern.py
    depends_on:
      - kibana
    environment:
      - KPROXY_ENDPOINT=http://kproxy:9201
      - KIBANA_ENDPOINT=http://kibana:5601
      - KIBANA_USER=elastic
      - KIBANA_PASSWORD=${var.ecs_instance_password}
      - SLS_ACCESS_KEY_ID=${alicloud_ram_access_key.ramak.id}
      - SLS_ACCESS_KEY_SECRET=${alicloud_ram_access_key.ramak.secret}
EOK

# 启动Kibana
docker compose up -d
docker compose ps
EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
}

resource "alicloud_ecs_invocation" "invoke_script_kibana" {
  instance_id = [alicloud_instance.ecs_instance_kibana.id]
  command_id  = alicloud_ecs_command.run_command_kibana.id
  timeouts {
    create = "15m"
  }
  depends_on = [ alicloud_instance.ecs_instance_kibana ]
}
