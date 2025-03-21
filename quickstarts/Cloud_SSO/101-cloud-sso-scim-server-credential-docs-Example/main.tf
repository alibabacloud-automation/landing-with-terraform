variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

data "alicloud_cloud_sso_directories" "default" {
}

resource "alicloud_cloud_sso_scim_server_credential" "default" {
  directory_id           = data.alicloud_cloud_sso_directories.default.directories.0.id
  credential_secret_file = "./credential_secret_file.txt"
}