data "alicloud_account" "default" {}

resource "alicloud_vpc" "example" {
  vpc_name   = "tf_example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_cen_instance" "example" {
  cen_instance_name = "tf_example"
  description       = "an example for cen"
}

resource "alicloud_cen_transit_router_grant_attachment" "example" {
  cen_id        = alicloud_cen_instance.example.id
  cen_owner_id  = data.alicloud_account.default.id
  instance_id   = alicloud_vpc.example.id
  instance_type = "VPC"
  order_type    = "PayByCenOwner"
}