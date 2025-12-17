provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "ecs_zones" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.ecs_instance_type
}

data "alicloud_db_zones" "rds_zones" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
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

resource "alicloud_vswitch" "ecs_vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_zones.ecs_zones.zones[0].id
  vswitch_name = "ecs-vswitch-${local.common_name}"
}

resource "alicloud_vswitch" "rds_vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.2.0/24"
  zone_id      = data.alicloud_db_zones.rds_zones.zones[0].id
  vswitch_name = "rds-vswitch-${local.common_name}"
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
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_web" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "0.0.0.0/0"
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
}

resource "alicloud_ram_user_policy_attachment" "attach_policy_to_user" {
  user_name   = alicloud_ram_user.ram_user.name
  policy_type = "System"
  policy_name = "AliyunLogFullAccess"
}

resource "alicloud_instance" "ecs_instance_provider" {
  instance_name              = "ecs-${local.common_name}"
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.ecs_instance_type
  system_disk_category       = "cloud_essd"
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.ecs_vswitch.id
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = 5
}

resource "alicloud_ecs_command" "run_command_provider" {
  name = "command-1-${local.common_name}"
  command_content = base64encode(<<EOF
cat << EOT >> ~/.bash_profile
export MYSQL_HOST=${alicloud_db_instance.rds_instance.connection_string}
export MYSQL_DB=testrmq
export MYSQL_USER=${var.db_account_name}
export MYSQL_PASSWORD=${var.db_password}
export APP_DEMO_ROCKETMQ_ENDPOINT=${alicloud_rocketmq_instance.rocketmq.network_info[0].endpoints[0].endpoint_url}
export APP_DEMO_ROCKETMQ_USERNAME=${var.rocketmq_username}
export APP_DEMO_ROCKETMQ_PASSWORD=${var.rocketmq_password}
export APP_DEMO_USERNAME=${var.app_demo_username}
export APP_DEMO_PASSWORD=${var.app_demo_password}
export IS_CONSUMER=false

EOT

source ~/.bash_profile

curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/install-script/rocketmq-transaction/install.sh|bash
EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
}

resource "alicloud_ecs_invocation" "invoke_script_provider" {
  instance_id = [alicloud_instance.ecs_instance_provider.id]
  command_id  = alicloud_ecs_command.run_command_provider.id
  timeouts {
    create = "15m"
  }
  depends_on = [
    alicloud_db_instance.rds_instance,
    alicloud_db_database.rds_database,
    alicloud_rocketmq_instance.rocketmq,
    alicloud_rocketmq_acl.topic1,
    alicloud_rocketmq_acl.consumer_group,
  ]
}


resource "alicloud_instance" "ecs_instance_consumer" {
  instance_name              = "ecs-${local.common_name}"
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.ecs_instance_type
  system_disk_category       = "cloud_essd"
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.ecs_vswitch.id
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = 5
}

resource "alicloud_ecs_command" "run_command_consumer" {
  name = "command-1-${local.common_name}"
  command_content = base64encode(<<EOF
cat << EOT >> ~/.bash_profile
export MYSQL_HOST=${alicloud_db_instance.rds_instance.connection_string}
export MYSQL_DB=testrmq
export MYSQL_USER=${var.db_account_name}
export MYSQL_PASSWORD=${var.db_password}
export APP_DEMO_ROCKETMQ_ENDPOINT=${alicloud_rocketmq_instance.rocketmq.network_info[0].endpoints[0].endpoint_url}
export APP_DEMO_ROCKETMQ_USERNAME=${var.rocketmq_username}
export APP_DEMO_ROCKETMQ_PASSWORD=${var.rocketmq_password}
export APP_DEMO_USERNAME=${var.app_demo_username}
export APP_DEMO_PASSWORD=${var.app_demo_password}
export IS_CONSUMER=true

EOT

source ~/.bash_profile

curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/install-script/rocketmq-transaction/install.sh|bash
EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
}

resource "alicloud_ecs_invocation" "invoke_script_consumer" {
  instance_id = [alicloud_instance.ecs_instance_consumer.id]
  command_id  = alicloud_ecs_command.run_command_consumer.id
  timeouts {
    create = "15m"
  }
  depends_on = [
    alicloud_db_instance.rds_instance,
    alicloud_db_database.rds_database,
    alicloud_rocketmq_instance.rocketmq,
    alicloud_rocketmq_acl.topic1,
    alicloud_rocketmq_acl.consumer_group,
  ]
}

resource "alicloud_db_instance" "rds_instance" {
  instance_type            = var.db_instance_type
  zone_id                  = data.alicloud_db_zones.rds_zones.zones[0].id
  instance_storage         = 50
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
  vswitch_id               = alicloud_vswitch.rds_vswitch.id
  engine                   = "MySQL"
  vpc_id                   = alicloud_vpc.vpc.id
  engine_version           = "8.0"
  security_ips             = ["192.168.0.0/16"]
}

resource "alicloud_rds_account" "rds_account" {
  db_instance_id   = alicloud_db_instance.rds_instance.id
  account_type     = "Normal"
  account_name     = var.db_account_name
  account_password = var.db_password
}

resource "alicloud_db_database" "rds_database" {
  character_set = "utf8"
  instance_id   = alicloud_db_instance.rds_instance.id
  name          = "testrmq"
}

resource "alicloud_db_account_privilege" "account_privilege" {
  privilege    = "ReadWrite"
  instance_id  = alicloud_db_instance.rds_instance.id
  account_name = alicloud_rds_account.rds_account.account_name
  db_names     = [alicloud_db_database.rds_database.name]
}

resource "alicloud_rocketmq_instance" "rocketmq" {
  product_info {
    msg_process_spec       = "rmq.s2.2xlarge"
    message_retention_time = "70"
  }

  sub_series_code = "cluster_ha"
  series_code     = "standard"
  payment_type    = "PayAsYouGo"
  instance_name   = "ROCKETMQ5-${local.common_name}"
  service_code    = "rmq"

  network_info {
    vpc_info {
      vpc_id = alicloud_vpc.vpc.id
      vswitches {
        vswitch_id = alicloud_vswitch.ecs_vswitch.id
      }
    }
    internet_info {
      internet_spec = "disable"
      flow_out_type = "uninvolved"
    }
  }
  acl_info {
    acl_types             = ["default", "apache_acl"]
    default_vpc_auth_free = false
  }

}

resource "alicloud_rocketmq_account" "default" {
  account_status = "ENABLE"
  instance_id    = alicloud_rocketmq_instance.rocketmq.id
  username       = var.rocketmq_username
  password       = var.rocketmq_password
}

resource "alicloud_rocketmq_topic" "topic1" {
  instance_id  = alicloud_rocketmq_instance.rocketmq.id
  remark       = "用于存储和传输订单相关的业务消息"
  message_type = "TRANSACTION"
  topic_name   = "ROCKETMQ_ORDER_TOPIC"
}

resource "alicloud_rocketmq_consumer_group" "consumer_group" {
  consumer_group_id   = "ROCKETMQ_LOGISTIC_CONSUMER_GROUP"
  instance_id         = alicloud_rocketmq_instance.rocketmq.id
  delivery_order_type = "Concurrently"
  consume_retry_policy {
    retry_policy    = "DefaultRetryPolicy"
    max_retry_times = 5
  }
}

resource "alicloud_rocketmq_acl" "topic1" {
  actions       = ["Pub", "Sub"]
  instance_id   = alicloud_rocketmq_instance.rocketmq.id
  username      = alicloud_rocketmq_account.default.username
  resource_name = alicloud_rocketmq_topic.topic1.topic_name
  resource_type = "Topic"
  decision      = "Allow"
  ip_whitelists = ["192.168.0.0/16"]
}

resource "alicloud_rocketmq_acl" "consumer_group" {
  actions       = ["Sub"]
  instance_id   = alicloud_rocketmq_instance.rocketmq.id
  username      = alicloud_rocketmq_account.default.username
  resource_name = alicloud_rocketmq_consumer_group.consumer_group.consumer_group_id
  resource_type = "Group"
  decision      = "Allow"
  ip_whitelists = ["192.168.0.0/16"]
}
