provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform_example"
}

resource "alicloud_pai_workspace_workspace" "defaultWorkspace" {
  description    = var.name
  display_name   = var.name
  workspace_name = var.name
  env_types      = ["prod"]
}


resource "alicloud_pai_workspace_dataset" "default" {
  options          = jsonencode({ "mountPath" : "/mnt/data/" })
  description      = var.name
  accessibility    = "PRIVATE"
  dataset_name     = var.name
  data_source_type = "NAS"
  source_type      = "ITAG"
  workspace_id     = alicloud_pai_workspace_workspace.defaultWorkspace.id
  data_type        = "PIC"
  property         = "DIRECTORY"
  uri              = "nas://086b649545.cn-hangzhou/"
  source_id        = "d-xxxxx_v1"
  user_id          = "1511928242963727"
}