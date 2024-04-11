resource "random_integer" "default" {
  max = 99999
  min = 10000
}

data "alicloud_resource_manager_resource_groups" "default" {
  name_regex = "default"
}

resource "alicloud_oss_bucket" "bucket-accelerate" {
  bucket            = "terraform-example-${random_integer.default.result}"
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups.0.id
}