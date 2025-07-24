provider "alicloud" {
  region = var.region_id
}

resource "random_id" "suffix" {
  byte_length = 8
}

locals {
  zone_id_1      = data.alicloud_db_zones.rds_zones.zones[length(data.alicloud_db_zones.rds_zones.zones) - 1].id
  zone_id_2      = data.alicloud_db_zones.rds_zones.zones[length(data.alicloud_db_zones.rds_zones.zones) - 2].id
  common_name    = random_id.suffix.id
  install_script = <<SCRIPT
#!/bin/sh
export ROS_DEPLOY=true
curl -fsSL https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/install-script/read-write-splitting-for-databases/install.sh | bash

SCRIPT
}

data "alicloud_db_zones" "rds_zones" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"

}
data "alicloud_db_instance_classes" "example" {
  zone_id                  = local.zone_id_1
  engine                   = data.alicloud_db_zones.rds_zones.engine
  engine_version           = data.alicloud_db_zones.rds_zones.engine_version
  category                 = data.alicloud_db_zones.rds_zones.category
  db_instance_storage_type = data.alicloud_db_zones.rds_zones.db_instance_storage_type
  instance_charge_type     = data.alicloud_db_zones.rds_zones.instance_charge_type
}

data "alicloud_instance_types" "default" {
  cpu_core_count       = 4
  system_disk_category = "cloud_essd"
  image_id             = data.alicloud_images.default.images[0].id
  instance_type_family = "ecs.c6"
  availability_zone    = local.zone_id_1
}

data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_x64_20G_alibase_*"
  most_recent = true
  owners      = "system"
}

# VPC Resources
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc"
  cidr_block = var.vpc_cidr_block
}

# VSwitch Resources
resource "alicloud_vswitch" "vswitch1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vswitch1_cidr_block
  zone_id      = local.zone_id_1
  vswitch_name = "vsw_001"
}

resource "alicloud_vswitch" "vswitch2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vswitch2_cidr_block
  zone_id      = local.zone_id_2
  vswitch_name = "vsw_002"
}

# Security Group
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg"
  security_group_type = "normal"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "140.205.11.1/25"
  security_group_id = alicloud_security_group.security_group.id
}

# ECS Resources
resource "alicloud_instance" "ecs_instance" {
  instance_name              = "ecs-${local.common_name}"
  system_disk_category       = data.alicloud_instance_types.default.system_disk_category
  system_disk_size           = 40
  image_id                   = data.alicloud_images.default.images[0].id
  vswitch_id                 = alicloud_vswitch.vswitch1.id
  password                   = var.ecs_instance_password
  instance_type              = data.alicloud_instance_types.default.instance_types[0].id
  internet_max_bandwidth_out = 5
  security_groups            = [alicloud_security_group.security_group.id]
}

# RDS Resources
resource "alicloud_db_instance" "database" {
  engine             = data.alicloud_db_instance_classes.example.engine
  engine_version     = data.alicloud_db_instance_classes.example.engine_version
  instance_type      = data.alicloud_db_instance_classes.example.instance_classes[0].instance_class
  instance_storage   = data.alicloud_db_instance_classes.example.instance_classes[0].storage_range.min
  instance_name      = "rds-${local.common_name}"
  vswitch_id         = alicloud_vswitch.vswitch1.id
  monitoring_period  = 60
  zone_id            = local.zone_id_1
  zone_id_slave_a    = local.zone_id_2
  category           = data.alicloud_db_instance_classes.example.category
  security_group_ids = [alicloud_security_group.security_group.id]
}

resource "alicloud_db_database" "rds_database" {
  instance_id   = alicloud_db_instance.database.id
  name          = var.db_name
  character_set = "utf8"
}

resource "alicloud_db_account" "db_account" {
  db_instance_id   = alicloud_db_instance.database.id
  account_name     = var.db_user_name
  account_password = var.db_password
  account_type     = "Normal"
}

resource "alicloud_db_account_privilege" "account_privilege" {
  instance_id  = alicloud_db_instance.database.id
  account_name = alicloud_db_account.db_account.account_name
  privilege    = "ReadWrite"
  db_names     = [alicloud_db_database.rds_database.name]
  depends_on   = [alicloud_db_database.rds_database]
}

# RDS DB Proxy
resource "alicloud_rds_db_proxy" "db_proxy" {
  instance_id            = alicloud_db_instance.database.id
  db_proxy_instance_type = "common"
  vpc_id                 = alicloud_vpc.vpc.id
  vswitch_id             = alicloud_vswitch.vswitch1.id
  db_proxy_features      = "ReadWriteSplitting"
  instance_network_type  = "VPC"
  db_proxy_instance_num  = 2
  depends_on             = [alicloud_db_account_privilege.account_privilege]
}

resource "alicloud_db_readonly_instance" "readonly_instance" {
  master_db_instance_id = alicloud_db_instance.database.id
  zone_id               = local.zone_id_2
  vswitch_id            = alicloud_vswitch.vswitch2.id
  instance_type         = "mysqlro.n2.medium.1c"
  instance_storage      = alicloud_db_instance.database.instance_storage
  instance_name         = "readonly-${local.common_name}"
  engine_version        = alicloud_db_instance.database.engine_version
  depends_on            = [alicloud_rds_db_proxy.db_proxy]
}

# ECS Command
resource "alicloud_ecs_command" "install_script" {
  name            = "install-${local.common_name}"
  command_content = base64encode(local.install_script)
  description     = "Install read-write splitting application"
  type            = "RunShellScript"
  working_dir     = "/root"
  timeout         = 3600
}

resource "alicloud_ecs_invocation" "run_install" {
  command_id  = alicloud_ecs_command.install_script.id
  instance_id = [alicloud_instance.ecs_instance.id]
  depends_on  = [alicloud_db_readonly_instance.readonly_instance]
  timeouts {
    create = "15m"
  }
}