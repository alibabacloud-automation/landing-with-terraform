variable "name" {
  default = "terraform-example"
}

resource "alicloud_threat_detection_malicious_file_whitelist_config" "default" {
  operator     = "strEquals"
  field        = "fileMd6"
  target_value = "123"
  target_type  = "SELECTION_KEY"
  event_name   = "123"
  source       = "agentless"
  field_value  = "sadfas"
}