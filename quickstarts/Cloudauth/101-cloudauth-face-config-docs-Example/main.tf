variable "name" {
  default = "tf_example"
}
provider "alicloud" {
  region = "cn-hangzhou"
}
resource "random_integer" "default" {
  max = 99999
  min = 10000
}
resource "alicloud_cloudauth_face_config" "example" {
  biz_name = format("%s-biz", var.name)
  biz_type = format("type-%s", random_integer.default.result)
}