variable "name" {
  default = "tf_example"
}
resource "alicloud_security_center_group" "example" {
  group_name = var.name
}