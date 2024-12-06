variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-shenzhen"
}

resource "alicloud_pai_workspace_workspace" "defaultgklBnM" {
  description    = "for-pop-example"
  display_name   = "CodeSourceTest_1732796227"
  workspace_name = var.name
  env_types      = ["prod"]
}


resource "alicloud_pai_workspace_code_source" "default" {
  mount_path             = "/mnt/code/dir_01/"
  code_repo              = "https://github.com/mattn/go-sqlite3.git"
  description            = "desc-01"
  code_repo_access_token = "token-01"
  accessibility          = "PRIVATE"
  display_name           = "codesource-example-01"
  workspace_id           = alicloud_pai_workspace_workspace.defaultgklBnM.id
  code_branch            = "master"
  code_repo_user_name    = "user-01"
}