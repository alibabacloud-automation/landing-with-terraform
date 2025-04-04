variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

variable "region_id" {
  default = "cn-beijing"
}


resource "alicloud_rds_custom_disk" "default" {
  description          = "zcc测试用例"
  zone_id              = "cn-beijing-i"
  size                 = "40"
  performance_level    = "PL1"
  instance_charge_type = "Postpaid"
  disk_category        = "cloud_essd"
  disk_name            = "custom_disk_001"
  auto_renew           = false
  period               = "1"
  auto_pay             = true
  period_unit          = "1"
}