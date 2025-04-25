variable "name" {
  default = "tf-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_cloud_sso_directory" "default" {
  directory_name = var.name
}