provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

resource "random_string" "suffix" {
  length  = 8
  lower   = true
  upper   = false
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

resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "192.168.0.0/24"
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

resource "alicloud_instance" "ecs_instance" {
  count                      = 2
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
sleep 60
# Install loongcollector
wget http://aliyun-observability-release-${var.region}.oss-${var.region}.aliyuncs.com/loongcollector/linux64/latest/loongcollector.sh -O loongcollector.sh
chmod +x loongcollector.sh
./loongcollector.sh install ${var.region}-internet
# Generate log
curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/tech-solution/install-log-monitoring-alarming-0.1.sh|bash
EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
  depends_on  = [alicloud_instance.ecs_instance]
}

resource "alicloud_ecs_invocation" "invoke_script" {
  instance_id = alicloud_instance.ecs_instance[*].id
  command_id  = alicloud_ecs_command.run_command.id
  timeouts {
    create = "15m"
  }
  depends_on = [alicloud_instance.ecs_instance]
}

resource "alicloud_log_project" "sls_project" {
  project_name = "sls-project-${local.common_name}"
}

resource "alicloud_log_store" "sls_log_store" {
  logstore_name = "sls-logstore-${local.common_name}"
  project_name  = alicloud_log_project.sls_project.project_name
  depends_on    = [alicloud_log_project.sls_project]
}

resource "alicloud_log_machine_group" "this" {
  identify_list = alicloud_instance.ecs_instance[*].primary_ip_address
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
  full_text {
    token = " :#$^*\r\n\t"
  }
  field_search {
    name  = "content"
    type  = "text"
    token = " :#$^*\r\n\t"
  }
  depends_on = [alicloud_log_store.sls_log_store]
}
