variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "defaultVpc" {
  cidr_block = "172.16.0.0/12"
  vpc_name   = var.name
}

resource "alicloud_vswitch" "defaultVSwitch" {
  vpc_id       = alicloud_vpc.defaultVpc.id
  zone_id      = "cn-hangzhou-j"
  cidr_block   = "172.16.53.0/24"
  vswitch_name = var.name
}

resource "alicloud_hologram_instance" "default" {
  instance_type = "Standard"
  pricing_cycle = "Hour"
  cpu           = "8"
  endpoints {
    type = "Intranet"
  }
  endpoints {
    type       = "VPCSingleTunnel"
    vswitch_id = alicloud_vswitch.defaultVSwitch.id
    vpc_id     = alicloud_vswitch.defaultVSwitch.vpc_id
  }

  zone_id       = alicloud_vswitch.defaultVSwitch.zone_id
  instance_name = var.name
  payment_type  = "PayAsYouGo"
}