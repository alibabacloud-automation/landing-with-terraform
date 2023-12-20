variable "name" {
  default = "tf_example_name"
}
resource "alicloud_sddp_rule" "default" {
  category      = "0"
  content       = "content"
  rule_name     = var.name
  risk_level_id = "4"
  product_code  = "OSS"
}