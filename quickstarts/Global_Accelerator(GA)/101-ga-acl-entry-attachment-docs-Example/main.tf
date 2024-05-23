resource "alicloud_ga_acl" "default" {
  acl_name           = "tf-example-value"
  address_ip_version = "IPv4"
}

resource "alicloud_ga_acl_entry_attachment" "default" {
  acl_id            = alicloud_ga_acl.default.id
  entry             = "192.168.1.1/32"
  entry_description = "tf-example-value"
}