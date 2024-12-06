variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_pai_workspace_workspace" "defaultDI9fsL" {
  description    = var.name
  display_name   = var.name
  workspace_name = var.name
  env_types      = ["prod"]
}


resource "alicloud_pai_workspace_experiment" "default" {
  accessibility   = "PRIVATE"
  artifact_uri    = "oss://yyt-409262.oss-cn-hangzhou.aliyuncs.com/example/"
  experiment_name = var.name
  workspace_id    = alicloud_pai_workspace_workspace.defaultDI9fsL.id
}