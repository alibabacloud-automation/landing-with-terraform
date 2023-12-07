variable "name" {
  default = "tf-example"
}

resource "alicloud_resource_manager_folder" "example" {
  folder_name = var.name
}
