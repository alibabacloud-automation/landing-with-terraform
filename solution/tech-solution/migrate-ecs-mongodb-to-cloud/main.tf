provider "alicloud" {
  region = var.region_id
}

resource "random_id" "suffix" {
  byte_length = 8
}
data "alicloud_mongodb_zones" "default" {
}

data "alicloud_instance_types" "default" {
  system_disk_category = "cloud_essd"
  image_id             = data.alicloud_images.default.images[0].id
  instance_type_family = "ecs.c6"
  availability_zone    = data.alicloud_mongodb_zones.default.zones[length(data.alicloud_mongodb_zones.default.zones) - 1].id
}

data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_x64_20G_alibase_*"
  most_recent = true
  owners      = "system"
}

locals {
  common_name = random_id.suffix.id
  ecs_command = <<SHELL
#!/bin/bash
cat << INNER_EOF >> ~/.bash_profile
export DB_NAME=${var.db_name}
export DB_USERNAME=${var.db_user_name}
export DB_PASSWORD=${var.db_password}
export ROS_DEPLOY=true
INNER_EOF

source ~/.bash_profile

curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/install-script/ecs-mongo-to-cloud/install_init.sh|bash
SHELL
}

# VPC Resources
resource "alicloud_vpc" "vpc" {
  vpc_name   = "VPC_HZ"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_mongodb_zones.default.zones[length(data.alicloud_mongodb_zones.default.zones) - 1].id
  vswitch_name = "vsw_001"
}

# Security Group
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg-mongodb-${local.common_name}"
  security_group_type = "normal"
}

# Security Group Rules
resource "alicloud_security_group_rule" "http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
  security_group_id = alicloud_security_group.security_group.id
}

resource "alicloud_security_group_rule" "rdp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "3389/3389"
  cidr_ip           = "0.0.0.0/0"
  security_group_id = alicloud_security_group.security_group.id
}

resource "alicloud_security_group_rule" "mongodb_ingress" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "27017/27017"
  cidr_ip           = "0.0.0.0/0"
  security_group_id = alicloud_security_group.security_group.id
}

resource "alicloud_security_group_rule" "mongodb_egress" {
  type              = "egress"
  ip_protocol       = "tcp"
  port_range        = "27017/27017"
  cidr_ip           = "0.0.0.0/0"
  security_group_id = alicloud_security_group.security_group.id
}

# MongoDB Resources
resource "alicloud_mongodb_instance" "mongodb" {
  engine_version      = "8.0"
  db_instance_class   = var.mongodb_instance_class
  db_instance_storage = 20
  name                = "mongodb_test"
  account_password    = var.mongodb_password
  security_ip_list    = ["192.168.1.0/24"]
  vpc_id              = alicloud_vpc.vpc.id
  vswitch_id          = alicloud_vswitch.vswitch.id
  storage_engine      = "WiredTiger"
  storage_type        = "cloud_essd1"
}

# ECS Resources
resource "alicloud_instance" "mongodb_server" {
  instance_name              = "mongodb-server-${local.common_name}"
  system_disk_category       = data.alicloud_instance_types.default.system_disk_category
  image_id                   = data.alicloud_images.default.images[0].id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  password                   = var.ecs_instance_password
  instance_type              = data.alicloud_instance_types.default.instance_types[0].id
  internet_max_bandwidth_out = 5
  security_groups            = [alicloud_security_group.security_group.id]
}

resource "alicloud_ecs_command" "run_command" {
  name             = "install-mongodb-${local.common_name}"
  description      = "install_mongodb_${local.common_name}_description"
  enable_parameter = false
  type             = "RunShellScript"
  command_content  = base64encode(local.ecs_command)
  timeout          = 3600
  working_dir      = "/root"
}

resource "alicloud_ecs_invocation" "install_mongodb" {
  instance_id = [alicloud_instance.mongodb_server.id]
  command_id  = alicloud_ecs_command.run_command.id
  depends_on  = [alicloud_mongodb_instance.mongodb, alicloud_instance.mongodb_server]
  timeouts {
    create = "10m"
  }
}