variable "name" {
  default = "example"
}
provider "alicloud" {
  region = "cn-hangzhou"
}
resource "alicloud_direct_mail_tag" "example" {
  tag_name = var.name
}