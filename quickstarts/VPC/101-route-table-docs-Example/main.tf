variable "name" {
  default = "terraform-example"
}

resource "alicloud_vpc" "defaultVpc" {
  vpc_name = var.name
}


resource "alicloud_route_table" "default" {
  description      = "test-description"
  vpc_id           = alicloud_vpc.defaultVpc.id
  route_table_name = var.name
  associate_type   = "VSwitch"
}