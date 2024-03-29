variable "name" {
  default = "tfexample"
}
provider "alicloud" {
  region = "cn-hangzhou"
}
resource "alicloud_direct_mail_receivers" "example" {
  receivers_alias = format("%s@onaliyun.com", var.name)
  receivers_name  = var.name
  description     = var.name
}