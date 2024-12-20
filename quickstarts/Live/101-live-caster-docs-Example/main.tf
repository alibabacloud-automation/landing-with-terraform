variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_live_caster" "default" {
  caster_name  = var.name
  payment_type = "PayAsYouGo"
  norm_type    = "1"
}