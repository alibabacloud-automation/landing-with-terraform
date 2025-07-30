# 查询实例实例规格
data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7"
  sorted_by            = "CPU"
}

data "alicloud_zones" "default" {
  available_instance_type     = data.alicloud_instance_types.default.ids.0
  available_resource_creation = "Rds"
}

locals {
  zone_id = data.alicloud_zones.default.ids[length(data.alicloud_zones.default.ids) - 1]
}

# 查询实例规格
data "alicloud_db_instance_classes" "default" {
  instance_charge_type     = "PostPaid"
  engine                   = "MySQL"
  engine_version           = "8.0"
  db_instance_storage_type = "cloud_essd"
  category                 = "Basic"
  zone_id                  = local.zone_id
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "${var.common_name}-vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = local.zone_id
  vswitch_name = "${var.common_name}-vsw"
}

resource "alicloud_security_group" "sg" {
  security_group_name = "${var.common_name}-sg"
  vpc_id              = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
  security_group_id = alicloud_security_group.sg.id
}

data "alicloud_images" "instance_image" {
  name_regex    = "^aliyun_3_9_x64_20G_*"
  most_recent   = true
  owners        = "system"
  instance_type = data.alicloud_instance_types.default.ids.0
}

resource "alicloud_instance" "ecs" {
  instance_name              = "${var.common_name}-ecs"
  instance_type              = data.alicloud_instance_types.default.ids.0
  vswitch_id                 = alicloud_vswitch.vsw.id
  security_groups            = [alicloud_security_group.sg.id]
  image_id                   = data.alicloud_images.instance_image.images.0.id
  system_disk_category       = "cloud_essd"
  internet_max_bandwidth_out = 5
  password                   = var.ecs_instance_password
  count                      = 2
}

resource "alicloud_db_instance" "rds" {
  engine               = "MySQL"
  engine_version       = "8.0"
  instance_type        = data.alicloud_db_instance_classes.default.ids.0
  instance_storage     = 40
  instance_charge_type = "Postpaid"
  vswitch_id           = alicloud_vswitch.vsw.id
  security_ips         = ["192.168.0.0/24"]
}

resource "alicloud_rds_account" "create_db_user" {
  db_instance_id   = alicloud_db_instance.rds.id
  account_name     = var.db_user_name
  account_password = var.db_password
  account_type     = "Super"
}

resource "alicloud_ecs_command" "deploy" {
  name            = "${var.common_name}-deploy"
  type            = "RunShellScript"
  command_content = base64encode(local.deploy_application_script)
  working_dir     = "/root"
  timeout         = 300
}

resource "alicloud_ecs_invocation" "deploy_invocation" {
  instance_id = alicloud_instance.ecs.*.id
  command_id  = alicloud_ecs_command.deploy.id
  timeouts {
    create = "5m"
  }
  depends_on = [alicloud_rds_account.create_db_user]
}

locals {
  deploy_application_script = <<-SHELL
  #!/bin/bash

  function log_info() {
      printf "%s [INFO] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
  }

  function log_error() {
      printf "%s [ERROR] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
  }

  function debug_exec(){
      local cmd="$@"
      log_info "$cmd"
      eval "$cmd"
      ret=$?
      echo ""
      log_info "$cmd, exit code: $ret"
      return $ret
  }

  cat << EOF >> ~/.bash_profile
  export DEMO_SCHEDULERX_ENDPOINT="addr-hz-internal.edas.aliyun.com"
  export DEMO_SCHEDULERX_NAMESPACE="${var.scheduler_x_namespace}"
  export DEMO_SCHEDULERX_GROUPID="${var.scheduler_x_group_id}"
  export DEMO_SCHEDULERX_APPKEY="${var.scheduler_x_app_key}"

  export DEMO_MYSQL_URL="${alicloud_db_instance.rds.connection_string}:3306"
  export DEMO_MYSQL_USERNAME="${var.db_user_name}"
  export DEMO_MYSQL_PASSWORD="${var.db_password}"

  export DEMO_USERNAME="${var.demo_user_name}"
  export DEMO_PASSWORD="${var.demo_user_password}"

  export ROS_DEPLOY=true
  EOF
  source ~/.bash_profile

  curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/install-script/mse-schedulerx/install.sh | bash
  SHELL
}