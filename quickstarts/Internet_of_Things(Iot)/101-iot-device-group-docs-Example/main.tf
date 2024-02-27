variable "name" {
  default = "tfexample"
}
resource "alicloud_iot_device_group" "example" {
  group_name = var.name
}