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

resource "alicloud_nas_access_group" "default" {
  access_group_type = "Vpc"
  description       = "ExtremeAccessGroup"
  access_group_name = "terraform-example-${random_integer.default.result}"
  file_system_type  = "extreme"
}

resource "alicloud_nas_access_rule" "default" {
  access_group_name   = alicloud_nas_access_group.default.access_group_name
  rw_access_type      = "RDONLY"
  ipv6_source_cidr_ip = "::1"
  user_access_type    = "no_squash"
  priority            = "1"
  file_system_type    = "extreme"
}