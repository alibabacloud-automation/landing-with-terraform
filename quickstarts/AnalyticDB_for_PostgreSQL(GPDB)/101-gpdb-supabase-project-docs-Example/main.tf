provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = "cn-hangzhou-j"
}

resource "alicloud_gpdb_supabase_project" "default" {
  project_spec           = "1C2G"
  zone_id                = "cn-hangzhou-j"
  vpc_id                 = data.alicloud_vpcs.default.ids.0
  project_name           = "supabase_example"
  security_ip_list       = ["127.0.0.1"]
  vswitch_id             = data.alicloud_vswitches.default.ids.0
  disk_performance_level = "PL0"
  storage_size           = "1"
  account_password       = "YourPassword123!"
}