variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
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