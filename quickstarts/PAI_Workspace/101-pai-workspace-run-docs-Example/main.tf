variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_pai_workspace_workspace" "defaultCAFUa9" {
  description    = var.name
  display_name   = var.name
  workspace_name = var.name
  env_types      = ["prod"]
}

resource "alicloud_pai_workspace_experiment" "defaultQRwWbv" {
  accessibility   = "PRIVATE"
  artifact_uri    = "oss://example.oss-cn-hangzhou.aliyuncs.com/example/"
  experiment_name = format("%s1", var.name)
  workspace_id    = alicloud_pai_workspace_workspace.defaultCAFUa9.id
}


resource "alicloud_pai_workspace_run" "default" {
  source_type   = "TrainingService"
  source_id     = "759"
  run_name      = var.name
  experiment_id = alicloud_pai_workspace_experiment.defaultQRwWbv.id
}