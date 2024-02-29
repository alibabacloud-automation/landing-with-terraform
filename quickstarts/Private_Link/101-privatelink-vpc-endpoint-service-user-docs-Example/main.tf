variable "name" {
  default = "tfexampleuser"
}

resource "alicloud_privatelink_vpc_endpoint_service" "example" {
  service_description    = var.name
  connect_bandwidth      = 103
  auto_accept_connection = false
}

resource "alicloud_ram_user" "example" {
  name         = var.name
  display_name = "user_display_name"
  mobile       = "86-18688888888"
  email        = "hello.uuu@aaa.com"
  comments     = "yoyoyo"
}

resource "alicloud_privatelink_vpc_endpoint_service_user" "example" {
  service_id = alicloud_privatelink_vpc_endpoint_service.example.id
  user_id    = alicloud_ram_user.example.id
}