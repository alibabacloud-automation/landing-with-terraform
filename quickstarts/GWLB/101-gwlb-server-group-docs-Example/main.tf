variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-wulanchabu"
}

variable "region_id" {
  default = "cn-wulanchabu"
}

variable "zone_id1" {
  default = "cn-wulanchabu-b"
}

resource "alicloud_vpc" "defaultEaxcvb" {
  cidr_block = "10.0.0.0/8"
  vpc_name   = var.name
}

resource "alicloud_vswitch" "defaultc3uVID" {
  vpc_id       = alicloud_vpc.defaultEaxcvb.id
  zone_id      = var.zone_id1
  cidr_block   = "10.0.0.0/24"
  vswitch_name = format("%s3", var.name)
}

resource "alicloud_security_group" "default" {
  name        = "tf-example"
  description = "New security group"
  vpc_id      = alicloud_vpc.defaultEaxcvb.id
}

resource "alicloud_instance" "default5DqP8f" {
  vswitch_id                 = alicloud_vswitch.defaultc3uVID.id
  image_id                   = "aliyun_2_1903_x64_20G_alibase_20231221.vhd"
  instance_type              = "ecs.g6.large"
  system_disk_category       = "cloud_efficiency"
  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = 5
  instance_name              = format("%s4", var.name)
  description                = "tf-example-ecs"
  security_groups            = [alicloud_security_group.default.id]
  availability_zone          = alicloud_vswitch.defaultc3uVID.zone_id
  instance_charge_type       = "PostPaid"
}

resource "alicloud_gwlb_server_group" "default" {
  protocol          = "GENEVE"
  server_group_type = "Instance"
  vpc_id            = alicloud_vpc.defaultEaxcvb.id
  dry_run           = "false"
  server_group_name = "tf-exampleacccn-wulanchabugwlbservergroup24005"
  servers {
    server_id   = alicloud_instance.default5DqP8f.id
    server_type = "Ecs"
  }

  scheduler = "5TCH"
}