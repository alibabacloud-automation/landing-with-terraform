provider "alicloud" {
  endpoints {
    bssopenapi = "business.aliyuncs.com"
  }
  region = "cn-hangzhou"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}
data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_yundun_dbaudit_instance" "default" {
  description = "tf-example"
  plan_code   = "alpha.professional"
  period      = "1"
  vswitch_id  = data.alicloud_vswitches.default.ids.0
}