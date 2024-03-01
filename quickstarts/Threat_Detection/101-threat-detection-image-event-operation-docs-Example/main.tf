variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_threat_detection_image_event_operation" "default" {
  event_type     = "maliciousFile"
  operation_code = "whitelist"
  event_key      = "alibabacloud_ak"
  scenarios      = <<EOF
{
  "type":"default",
  "value":""
}
EOF
  event_name     = "阿里云AK"
  conditions     = <<EOF
[
  {
      "condition":"MD5",
      "type":"equals",
      "value":"0083a31cc0083a31ccf7c10367a6e783e"
  }
]
EOF
}