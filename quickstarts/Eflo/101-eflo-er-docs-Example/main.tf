variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_resource_manager_resource_groups" "default" {}


resource "alicloud_eflo_er" "default" {
  er_name        = "er-example-tf"
  master_zone_id = "cn-hangzhou-a"
  description    = "example"
}