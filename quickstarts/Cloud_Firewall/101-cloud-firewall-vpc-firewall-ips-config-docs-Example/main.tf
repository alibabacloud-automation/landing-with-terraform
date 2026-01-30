variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = ""
}


resource "alicloud_cloud_firewall_vpc_firewall_ips_config" "default" {
  enable_all_patch = "0"
  basic_rules      = "0"
  run_mode         = "0"
  vpc_firewall_id  = "vfw-tr-bb81adb2d8184bc290a5"
  rule_class       = "0"
  lang             = "cn-shenzhen"
  member_uid       = "1094685339207557"
}