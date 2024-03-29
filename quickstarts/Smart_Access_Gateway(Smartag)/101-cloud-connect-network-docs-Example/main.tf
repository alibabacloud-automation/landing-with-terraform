variable "name" {
  default = "terraform-example"
}
provider "alicloud" {
  region = "cn-shanghai"
}
resource "alicloud_cloud_connect_network" "default" {
  name        = var.name
  description = var.name
  cidr_block  = "192.168.0.0/24"
  is_default  = true
}