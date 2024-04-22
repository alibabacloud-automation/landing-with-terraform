variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
  cidr_block = "172.16.0.0/16"
}
data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = "cn-hangzhou-h"
}

resource "alicloud_kms_instance" "default" {
  product_version = "3"
  vpc_id          = data.alicloud_vpcs.default.ids.0
  zone_ids = [
    "cn-hangzhou-h",
    "cn-hangzhou-g"
  ]
  vswitch_ids = [
    data.alicloud_vswitches.default.ids.0
  ]
  vpc_num    = "1"
  key_num    = "1000"
  secret_num = "0"
  spec       = "1000"
}

resource "alicloud_kms_key" "this" {
  pending_window_in_days = 7
  dkms_instance_id       = alicloud_kms_instance.default.id

}

resource "alicloud_kms_key_version" "keyversion" {
  key_id = alicloud_kms_key.this.id
}