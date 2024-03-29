variable "name" {
  default = "tf-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_resource_manager_folder" "example" {
  folder_name = "${var.name}-${random_integer.default.result}"
}