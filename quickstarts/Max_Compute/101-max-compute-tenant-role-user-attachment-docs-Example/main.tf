variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_max_compute_tenant_role_user_attachment" "default0" {
  account_id  = "p4_200053869413670560"
  tenant_role = "admin"
}