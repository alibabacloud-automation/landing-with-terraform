resource "alicloud_cloud_firewall_instance_v2" "default" {
  payment_type = "PayAsYouGo"
  product_code = "cfw"
  product_type = "cfw_elasticity_public_cn"
  spec         = "payg_version"
}