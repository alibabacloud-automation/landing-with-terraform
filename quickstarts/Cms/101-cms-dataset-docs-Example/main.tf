variable "name" {
  default = "terraform-example"
}

resource "alicloud_log_project" "default" {
  project_name = var.name
}

resource "alicloud_cms_workspace" "default" {
  workspace_name = var.name
  sls_project    = alicloud_log_project.default.project_name
}

resource "alicloud_cms_dataset" "default" {
  workspace    = alicloud_cms_workspace.default.workspace_name
  dataset_name = var.name
  description  = "terraform-example"
  schema       = jsonencode({ type = "record", name = "example", fields = [{ name = "metric", type = "string" }] })
}