variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_dms_user_tenants" "default" {
  status = "ACTIVE"
}

resource "alicloud_dms_enterprise_authority_template" "default" {
  tid                     = data.alicloud_dms_user_tenants.default.ids.0
  authority_template_name = var.name
  description             = var.name
}