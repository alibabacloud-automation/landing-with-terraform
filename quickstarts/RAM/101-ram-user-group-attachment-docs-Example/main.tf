variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ram_user" "default" {
  name         = "terraform-example-${random_integer.default.result}"
  display_name = "terraform-example-${random_integer.default.result}"
}

resource "alicloud_ram_group" "default" {
  name = "terraform-example-${random_integer.default.result}"
}

resource "alicloud_ram_user_group_attachment" "default" {
  group_name = alicloud_ram_group.default.id
  user_name  = alicloud_ram_user.default.name
}