provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_oos_application" "default" {
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  application_name  = "${var.name}-${random_integer.default.result}"
  description       = var.name
  tags = {
    Created = "TF"
  }
}
data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_oos_application_group" "default" {
  application_group_name = var.name
  application_name       = alicloud_oos_application.default.id
  deploy_region_id       = data.alicloud_regions.default.regions.0.id
  description            = var.name
  import_tag_key         = "example_key"
  import_tag_value       = "example_value"
}