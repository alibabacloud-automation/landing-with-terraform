resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_nas_access_group" "foo" {
  access_group_name = "terraform-example-${random_integer.default.result}"
  access_group_type = "Vpc"
  description       = "terraform-example"
  file_system_type  = "extreme"
}