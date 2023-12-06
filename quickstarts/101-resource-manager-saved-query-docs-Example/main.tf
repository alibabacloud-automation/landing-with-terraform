variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_resource_manager_saved_query" "default" {
  description      = var.name
  expression       = "select * from resources limit 1;"
  saved_query_name = var.name

}
