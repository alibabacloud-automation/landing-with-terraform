resource "alicloud_security_group" "group" {
  name   = "terraform-example"
  vpc_id = alicloud_vpc.vpc.id
}
resource "alicloud_vpc" "vpc" {
  vpc_name   = "terraform-example"
  cidr_block = "10.1.0.0/21"
}