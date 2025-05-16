variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_pai_workspace_workspace" "Workspace" {
  description    = "156"
  display_name   = var.name
  workspace_name = "${var.name}_${random_integer.default.result}"
  env_types      = ["prod"]
}

resource "alicloud_ram_user" "default" {
  name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_pai_workspace_member" "default" {
  user_id      = alicloud_ram_user.default.id
  workspace_id = alicloud_pai_workspace_workspace.Workspace.id
  roles        = ["PAI.AlgoDeveloper", "PAI.AlgoOperator", "PAI.LabelManager"]
}