resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_dfs_access_group" "default" {
  access_group_name = "tf-example-${random_integer.default.result}"
  network_type      = "VPC"
}