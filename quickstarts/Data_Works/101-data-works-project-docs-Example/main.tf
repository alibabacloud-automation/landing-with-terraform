variable "name" {
  default = "tf_example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_data_works_project" "default" {
  project_name = "${var.name}_${random_integer.default.result}"
  project_mode = "2"
  description  = "${var.name}_${random_integer.default.result}"
  display_name = "${var.name}_${random_integer.default.result}"
  status       = "0"
}