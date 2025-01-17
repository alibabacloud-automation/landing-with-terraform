variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-guangzhou"
}


resource "alicloud_hbr_cross_account" "default" {
  cross_account_user_id   = "1"
  cross_account_role_name = var.name
  alias                   = var.name
}