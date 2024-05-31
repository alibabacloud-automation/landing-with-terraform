variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_api_gateway_instance" "defaultxywS8c" {
  instance_name = var.name
  instance_spec = "api.s1.small"
  https_policy  = "HTTPS2_TLS1_0"
  zone_id       = "cn-hangzhou-MAZ6"
  payment_type  = "PayAsYouGo"
}


resource "alicloud_api_gateway_access_control_list" "default" {
  access_control_list_name = var.name
  acl_entrys {
    acl_entry_ip      = "128.0.0.1/32"
    acl_entry_comment = "example comment"
  }
  address_ip_version = "ipv4"
}