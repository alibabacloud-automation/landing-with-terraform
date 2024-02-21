variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_resource_manager_resource_groups" "default" {
}

resource "alicloud_arms_grafana_workspace" "default" {
  grafana_version           = "9.0.x"
  description               = var.name
  resource_group_id         = data.alicloud_resource_manager_resource_groups.default.ids.0
  grafana_workspace_edition = "standard"
  grafana_workspace_name    = var.name
  tags = {
    Created = "tf"
    For     = "example"
  }
}