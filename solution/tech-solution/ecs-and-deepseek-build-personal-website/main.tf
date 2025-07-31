provider "alicloud" {
  region = var.region
}

resource "random_id" "suffix" {
  byte_length = 8
}

locals {
  common_name = "${var.CommonName}-${random_id.suffix.hex}"
}

resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "${local.common_name}-vpc"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = var.ZoneId
  vswitch_name = "${local.common_name}-vsw"
}

resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "${local.common_name}-sg"
}

resource "alicloud_security_group_rule" "allow_tcp_8080" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "8080/8080"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "ecs_instance" {
  instance_name              = "${local.common_name}-ecs"
  system_disk_category       = "cloud_essd"
  image_id                   = "aliyun_3_x64_20G_alibase_20250117.vhd"
  vswitch_id                 = alicloud_vswitch.vswitch.id
  password                   = var.ecs_instance_password
  instance_type              = var.InstanceType
  internet_max_bandwidth_out = 10
  security_groups            = [alicloud_security_group.security_group.id]
}

resource "alicloud_ram_user" "user" {
  name = "create_by_solution-${local.common_name}"
}

resource "alicloud_ecs_command" "install_app" {
  name = "install-deepseek-app"
  command_content = base64encode(<<EOF
    #!/bin/bash
    cat <<EOT >> ~/.bash_profile
    export API_KEY="${var.bai_lian_api_key}"
    export ROS_DEPLOY=true
    EOT

    source ~/.bash_profile 
    curl -fsSL https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/install-script/deepseek-r1-private/install.sh|bash
    EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
}

resource "alicloud_ecs_invocation" "invoke_script" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.install_app.id
  timeouts {
    create = "15m"
  }
}
