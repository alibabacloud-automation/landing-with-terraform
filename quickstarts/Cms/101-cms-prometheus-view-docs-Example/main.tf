variable "name" {
  default = "terraform-example"
}

data "alicloud_account" "default" {
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_log_project" "default" {
  project_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_cms_workspace" "default" {
  workspace_name = "${var.name}-${random_integer.default.result}"
  sls_project    = alicloud_log_project.default.project_name
}

resource "alicloud_cms_prometheus_instance" "default" {
  prometheus_instance_name = "${var.name}-${random_integer.default.result}"
  workspace                = alicloud_cms_workspace.default.id
}

resource "alicloud_cms_prometheus_view" "default" {
  prometheus_view_name = "${var.name}-${random_integer.default.result}"
  version              = "V2"
  prometheus_instances {
    prometheus_instance_id = alicloud_cms_prometheus_instance.default.id
    region_id              = alicloud_cms_prometheus_instance.default.region_id
    user_id                = data.alicloud_account.default.id
  }
  workspace = alicloud_cms_prometheus_instance.default.workspace
}