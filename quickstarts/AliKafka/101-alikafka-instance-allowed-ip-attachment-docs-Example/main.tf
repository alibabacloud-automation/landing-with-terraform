variable "name" {
  default = "tf-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_alikafka_instance" "default" {
  name           = "${var.name}-${random_integer.default.result}"
  partition_num  = 50
  disk_type      = 1
  disk_size      = 500
  deploy_type    = 5
  io_max         = 20
  vswitch_id     = alicloud_vswitch.default.id
  security_group = alicloud_security_group.default.id
}

resource "alicloud_alikafka_instance_allowed_ip_attachment" "default" {
  allowed_ip   = "114.237.9.78/32"
  allowed_type = "vpc"
  instance_id  = alicloud_alikafka_instance.default.id
  port_range   = "9092/9092"
}