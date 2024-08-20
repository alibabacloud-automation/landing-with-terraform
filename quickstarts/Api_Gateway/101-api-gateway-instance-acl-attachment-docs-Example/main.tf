variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_api_gateway_instance" "default" {
  instance_name = var.name
  instance_spec = "api.s1.small"
  https_policy  = "HTTPS2_TLS1_0"
  zone_id       = "cn-hangzhou-MAZ6"
  payment_type  = "PayAsYouGo"
  instance_type = "normal"
}

resource "alicloud_api_gateway_access_control_list" "default" {
  access_control_list_name = var.name
  address_ip_version       = "ipv4"
}

resource "alicloud_api_gateway_acl_entry_attachment" "default" {
  acl_id  = alicloud_api_gateway_access_control_list.default.id
  entry   = "128.0.0.1/32"
  comment = "test comment"
}

resource "alicloud_api_gateway_instance_acl_attachment" "default" {
  instance_id = alicloud_api_gateway_instance.default.id
  acl_id      = alicloud_api_gateway_access_control_list.default.id
  acl_type    = "white"
}