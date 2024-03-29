variable "name" {
  default = "tfexample"
}

resource "alicloud_resource_manager_resource_group" "example" {
  resource_group_name = var.name
  display_name        = var.name
}