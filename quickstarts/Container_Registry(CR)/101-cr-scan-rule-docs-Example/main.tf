variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_cr_ee_instance" "default2Aqoce" {
  default_oss_bucket = "false"
  renewal_status     = "ManualRenewal"
  period             = "1"
  instance_name      = "pl-example-2"
  payment_type       = "Subscription"
  instance_type      = "Basic"
}


resource "alicloud_cr_scan_rule" "default" {
  repo_tag_filter_pattern = ".*"
  scan_scope              = "REPO"
  trigger_type            = "MANUAL"
  scan_type               = "VUL"
  rule_name               = var.name
  namespaces              = ["aa"]
  repo_names              = ["bb", "cc", "dd", "ee"]
  instance_id             = alicloud_cr_ee_instance.default2Aqoce.id
}