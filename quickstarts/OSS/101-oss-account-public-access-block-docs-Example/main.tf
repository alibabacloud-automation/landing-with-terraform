variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_oss_account_public_access_block" "default" {
  block_public_access = true
}