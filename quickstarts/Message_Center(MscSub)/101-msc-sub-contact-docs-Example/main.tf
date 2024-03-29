variable "name" {
  default = "tfexample"
}

resource "alicloud_msc_sub_contact" "default" {
  contact_name = var.name
  position     = "CEO"
  email        = "123@163.com"
  mobile       = "15388888888"
}