provider "alicloud" {
  region = var.region_id
}

resource "random_id" "suffix" {
  byte_length = 8
}

data "alicloud_kvstore_zones" "zones_ids" {
  instance_charge_type = "PostPaid"
}

data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_x64_20G_alibase_*"
  most_recent = true
  owners      = "system"
}

data "alicloud_instance_types" "default" {
  cpu_core_count       = 4
  system_disk_category = "cloud_essd"
  image_id             = data.alicloud_images.default.images[0].id
  instance_type_family = "ecs.c6"
  availability_zone    = data.alicloud_kvstore_zones.zones_ids.zones[length(data.alicloud_kvstore_zones.zones_ids.zones) - 1].id
}

locals {
  common_name          = random_id.suffix.id
  redis_install_script = <<-SCRIPT
#!/bin/bash
export ROS_DEPLOY=true
curl -fsSL https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/install-script/read-write-splitting-through-tair-proxy/install.sh | bash
SCRIPT
}

# VPC Resources
resource "alicloud_vpc" "vpc" {
  vpc_name   = "VPC_HZ"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_kvstore_zones.zones_ids.zones[length(data.alicloud_kvstore_zones.zones_ids.zones) - 1].id
  vswitch_name = "vsw_001"
}

# Security Group
resource "alicloud_security_group" "ecs_security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "SecurityGroup_1"
  security_group_type = "normal"
}

resource "alicloud_security_group_rule" "http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "192.168.0.0/16"
  security_group_id = alicloud_security_group.ecs_security_group.id
}

# Redis Instance
resource "alicloud_kvstore_instance" "redis" {
  db_instance_name = "redis"
  instance_class   = "redis.shard.small.2.ce"
  engine_version   = "7.0"
  password         = var.db_password
  payment_type     = "PostPaid"
  vswitch_id       = alicloud_vswitch.vswitch.id
  zone_id          = data.alicloud_kvstore_zones.zones_ids.zones[length(data.alicloud_kvstore_zones.zones_ids.zones) - 1].id
  read_only_count  = 1
  security_ips     = ["192.168.0.0/16"]
}

# ECS Instance
resource "alicloud_instance" "ecs_instance" {
  instance_name              = "ecs-${local.common_name}"
  system_disk_category       = data.alicloud_instance_types.default.system_disk_category
  system_disk_size           = 100
  image_id                   = data.alicloud_images.default.images[0].id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  password                   = var.ecs_instance_password
  instance_type              = data.alicloud_instance_types.default.instance_types[0].id
  internet_max_bandwidth_out = 5
  security_groups            = [alicloud_security_group.ecs_security_group.id]
}

# Install Redis Client Command
resource "alicloud_ecs_command" "install_redis_client" {
  name            = "install-redis-client-${local.common_name}"
  description     = "Install Redis client on ECS instance"
  type            = "RunShellScript"
  command_content = base64encode(local.redis_install_script)
  timeout         = 600
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "install_redis_client" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.install_redis_client.id
  depends_on  = [alicloud_kvstore_instance.redis]
  timeouts {
    create = "10m"
  }
}