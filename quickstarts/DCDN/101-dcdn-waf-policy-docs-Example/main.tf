variable "name" {
  default = "tf_example"
}
resource "alicloud_dcdn_waf_policy" "example" {
  defense_scene = "waf_group"
  policy_name   = var.name
  policy_type   = "custom"
  status        = "on"
}