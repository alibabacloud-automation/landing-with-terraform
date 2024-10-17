variable "name" {
  default = "terraform-example"
}

resource "alicloud_cloud_firewall_control_policy" "default" {
  direction        = "in"
  application_name = "ANY"
  description      = var.name
  acl_action       = "accept"
  source           = "127.0.0.1/32"
  source_type      = "net"
  destination      = "127.0.0.2/32"
  destination_type = "net"
  proto            = "ANY"
}

resource "alicloud_cloud_firewall_control_policy_order" "default" {
  acl_uuid  = alicloud_cloud_firewall_control_policy.default.acl_uuid
  direction = alicloud_cloud_firewall_control_policy.default.direction
  order     = 1
}