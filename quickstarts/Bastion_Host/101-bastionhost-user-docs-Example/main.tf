variable "name" {
  default = "tf_example"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
  cidr_block = "10.4.0.0/16"
}

data "alicloud_vswitches" "default" {
  cidr_block = "10.4.0.0/24"
  vpc_id     = data.alicloud_vpcs.default.ids.0
  zone_id    = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  vpc_id = data.alicloud_vpcs.default.ids.0
}

resource "alicloud_bastionhost_instance" "default" {
  description        = var.name
  license_code       = "bhah_ent_50_asset"
  plan_code          = "cloudbastion"
  storage            = "5"
  bandwidth          = "5"
  period             = "1"
  vswitch_id         = data.alicloud_vswitches.default.ids[0]
  security_group_ids = [alicloud_security_group.default.id]
}

resource "alicloud_bastionhost_user" "local_user" {
  instance_id         = alicloud_bastionhost_instance.default.id
  mobile_country_code = "CN"
  mobile              = "13312345678"
  password            = "YourPassword-123"
  source              = "Local"
  user_name           = "${var.name}_local_user"
}

resource "alicloud_ram_user" "user" {
  name         = "${var.name}_bastionhost_user"
  display_name = "${var.name}_bastionhost_user"
  mobile       = "86-18688888888"
  email        = "hello.uuu@aaa.com"
  comments     = "yoyoyo"
  force        = true
}
data "alicloud_account" "default" {}
resource "alicloud_bastionhost_user" "ram_user" {
  instance_id    = alicloud_bastionhost_instance.default.id
  source         = "Ram"
  source_user_id = data.alicloud_account.default.id
  user_name      = alicloud_ram_user.user.name
}