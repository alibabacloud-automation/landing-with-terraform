variable "name" {
  default = "terraform-example"
}
provider "alicloud" {
  region = "ap-southeast-1"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}
resource "alicloud_vpc" "example" {
  vpc_name = var.name
}
resource "alicloud_vswitch" "example" {
  vpc_id       = alicloud_vpc.example.id
  zone_id      = data.alicloud_zones.default.zones.0.id
  cidr_block   = "172.16.0.0/24"
  vswitch_name = var.name
}
resource "alicloud_drds_polardbx_instance" "default" {
  topology_type  = "3azones"
  vswitch_id     = alicloud_vswitch.example.id
  primary_zone   = "ap-southeast-1a"
  cn_node_count  = "2"
  dn_class       = "mysql.n4.medium.25"
  cn_class       = "polarx.x4.medium.2e"
  dn_node_count  = "2"
  secondary_zone = "ap-southeast-1b"
  tertiary_zone  = "ap-southeast-1c"
  vpc_id         = alicloud_vpc.example.id
}