variable "name" {
  default = "terraform-example"
}

resource "alicloud_ga_acl" "default" {
  address_ip_version = "IPv4"
  acl_name           = var.name
}

resource "alicloud_ga_acl_entry_attachment" "default" {
  acl_id            = alicloud_ga_acl.default.id
  entry             = "192.168.1.1/32"
  entry_description = var.name
}