variable "name" {
  default = "tfexamplename"
}
resource "alicloud_ram_user" "default" {
  name         = var.name
  display_name = var.name
  mobile       = "86-18688888888"
  email        = "hello.uuu@aaa.com"
  comments     = "example"
}

resource "alicloud_dms_enterprise_user" "default" {
  uid        = alicloud_ram_user.default.id
  user_name  = var.name
  role_names = ["DBA"]
  mobile     = "86-18688888888"
}