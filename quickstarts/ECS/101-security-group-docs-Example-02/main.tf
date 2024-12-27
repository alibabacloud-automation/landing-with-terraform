resource "alicloud_vpc" "default" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_security_group" "default" {
  security_group_name = "terraform-example"
  vpc_id              = alicloud_vpc.default.id
}