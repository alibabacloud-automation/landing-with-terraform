variable "region" {
  default = "cn-shenzhen"
}

provider "alicloud" {
  region = var.region
}

variable "zone_id" {
  default = "cn-shenzhen-f"
}

# 创建VPC
resource "alicloud_vpc" "main" {
  vpc_name   = "alicloud"
  cidr_block = "172.16.0.0/16"
}

# 创建交换机
resource "alicloud_vswitch" "main" {
  vpc_id     = alicloud_vpc.main.id
  cidr_block = "172.16.192.0/20"
  zone_id    = var.zone_id
}

# 创建hologram实例
resource "alicloud_hologram_instance" "default" {
  instance_type = "Standard"
  pricing_cycle = "Hour"
  cpu           = "8"
  endpoints {
    type = "Intranet"
  }
  endpoints {
    type       = "VPCSingleTunnel"
    vswitch_id = alicloud_vswitch.main.id
    vpc_id     = alicloud_vswitch.main.vpc_id
  }
  zone_id       = alicloud_vswitch.main.zone_id
  instance_name = "terraform-hologram"
  payment_type  = "PayAsYouGo"
}