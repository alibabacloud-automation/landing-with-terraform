provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "terraform-example"
}
data "alicloud_regions" "default" {
  current = true
}
data "alicloud_express_connect_physical_connections" "default" {
  name_regex = "^preserved-NODELETING"
}
resource "random_integer" "vlan_id" {
  max = 2999
  min = 1
}
resource "alicloud_express_connect_virtual_border_router" "example" {
  local_gateway_ip           = "10.0.0.1"
  peer_gateway_ip            = "10.0.0.2"
  peering_subnet_mask        = "255.255.255.252"
  physical_connection_id     = data.alicloud_express_connect_physical_connections.default.connections.0.id
  virtual_border_router_name = var.name
  vlan_id                    = random_integer.vlan_id.id
  min_rx_interval            = 1000
  min_tx_interval            = 1000
  detect_multiplier          = 10
}
resource "alicloud_cen_instance" "example" {
  cen_instance_name = var.name
  protection_level  = "REDUCED"
}
resource "alicloud_cen_instance_attachment" "example" {
  instance_id              = alicloud_cen_instance.example.id
  child_instance_id        = alicloud_express_connect_virtual_border_router.example.id
  child_instance_type      = "VBR"
  child_instance_region_id = data.alicloud_regions.default.regions.0.id
}
resource "alicloud_cen_vbr_health_check" "example" {
  cen_id                 = alicloud_cen_instance.example.id
  health_check_source_ip = "192.168.1.2"
  health_check_target_ip = "10.0.0.2"
  vbr_instance_id        = alicloud_express_connect_virtual_border_router.example.id
  vbr_instance_region_id = alicloud_cen_instance_attachment.example.child_instance_region_id
  health_check_interval  = 2
  healthy_threshold      = 8
}