variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_cloud_firewall_instance" "default" {
  payment_type = "PayAsYouGo"
}

resource "alicloud_cloud_firewall_ips_config" "default" {
  lang = "zh"
  depends_on = [
    "alicloud_cloud_firewall_instance.default"
  ]
  max_sdl     = "1000"
  basic_rules = "1"
  run_mode    = "1"
  cti_rules   = "0"
  patch_rules = "0"
  rule_class  = "1"
}