variable "name" {
  default = "terraform-example"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = "cn-hangzhou-i"
}

data "alicloud_security_groups" "default" {
  vpc_id     = data.alicloud_vpcs.default.ids.0
  name_regex = "default-NODELETING"
}

resource "alicloud_rds_custom" "default" {
  zone_id              = data.alicloud_vswitches.default.zone_id
  instance_charge_type = "PostPaid"
  vswitch_id           = data.alicloud_vswitches.default.ids.0
  amount               = "1"
  security_group_ids   = [data.alicloud_security_groups.default.ids.0]
  system_disk {
    size = "40"
  }
  force         = true
  instance_type = "mysql.x4.xlarge.6cm"
  spot_strategy = "NoSpot"
}

resource "alicloud_rds_custom_disk" "default" {
  zone_id       = data.alicloud_vswitches.default.zone_id
  size          = "40"
  disk_category = "cloud_ssd"
  auto_pay      = true
  disk_name     = "ran_disk_attach"
}

resource "alicloud_rds_custom_disk_attachment" "default" {
  instance_id = alicloud_rds_custom.default.id
  disk_id     = alicloud_rds_custom_disk.default.id
}