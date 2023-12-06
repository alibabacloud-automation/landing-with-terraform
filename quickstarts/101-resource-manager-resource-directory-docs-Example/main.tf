data "alicloud_resource_manager_resource_directories" "default" {
}

resource "alicloud_resource_manager_resource_directory" "default" {
  count  = length(data.alicloud_resource_manager_resource_directories.default.directories) > 0 ? 0 : 1
  status = "Enabled"
}
