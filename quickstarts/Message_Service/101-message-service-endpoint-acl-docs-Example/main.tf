provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_message_service_endpoint" "default" {
  endpoint_enabled = true
  endpoint_type    = "public"
}

resource "alicloud_message_service_endpoint_acl" "default" {
  cidr          = "192.168.1.1/23"
  endpoint_type = alicloud_message_service_endpoint.default.id
  acl_strategy  = "allow"
}