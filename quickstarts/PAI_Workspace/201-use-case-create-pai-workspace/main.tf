resource "alicloud_pai_workspace_workspace" "default" {
  description    = "test_terraform_workspace"
  workspace_name = "test_terraform_workspace"
  display_name   = "test_terraform_workspace"
  env_types      = ["prod"]
}