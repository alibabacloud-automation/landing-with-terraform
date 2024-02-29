variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_threat_detection_client_file_protect" "default" {
  status      = "0"
  file_paths  = ["/usr/local"]
  file_ops    = ["CREATE"]
  rule_action = "pass"
  proc_paths  = ["/usr/local"]
  alert_level = "0"
  switch_id   = "FILE_PROTECT_RULE_SWITCH_TYPE_1693474122929"
  rule_name   = "rule_example"
}