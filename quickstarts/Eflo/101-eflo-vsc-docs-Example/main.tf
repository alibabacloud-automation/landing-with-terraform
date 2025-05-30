variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_eflo_vsc" "default" {
  vsc_type = "primary"
  node_id  = "e01-cn-9me49omda01"
  vsc_name = var.name
}