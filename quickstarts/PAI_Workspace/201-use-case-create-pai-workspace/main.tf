resource "alicloud_pai_workspace_workspace" "default" {
  description    = "example_terraform_workspace"
  workspace_name = "example_terraform_workspace"
  display_name   = "example_terraform_workspace"
  env_types      = ["prod"]
}