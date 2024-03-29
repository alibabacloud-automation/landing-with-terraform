provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}

data "alicloud_resource_manager_resource_groups" "default" {
}

data "alicloud_instances" "default" {
  status = "Running"
}

resource "alicloud_bp_studio_application" "default" {
  application_name  = var.name
  template_id       = "YAUUQIYRSV1CMFGX"
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  area_id           = "cn-hangzhou"
  instances {
    id        = "data.alicloud_instances.default.instances.0.id"
    node_name = "data.alicloud_instances.default.instances.0.name"
    node_type = "ecs"
  }
  configuration = {
    enableMonitor = "1"
  }
  variables = {
    test = "1"
  }
}
