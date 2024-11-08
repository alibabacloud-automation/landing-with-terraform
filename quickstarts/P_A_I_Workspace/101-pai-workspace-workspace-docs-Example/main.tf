variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_pai_workspace_workspace" "default" {
  description    = var.name
  workspace_name = var.name
  display_name   = var.name
  env_types      = ["prod"]
}