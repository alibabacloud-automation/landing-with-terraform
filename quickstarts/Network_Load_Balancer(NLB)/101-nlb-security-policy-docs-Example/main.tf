variable "name" {
  default = "tf-example"
}
data "alicloud_resource_manager_resource_groups" "default" {}
resource "alicloud_nlb_security_policy" "default" {
  resource_group_id    = data.alicloud_resource_manager_resource_groups.default.ids.0
  security_policy_name = var.name
  ciphers              = ["ECDHE-RSA-AES128-SHA", "ECDHE-ECDSA-AES128-SHA"]
  tls_versions         = ["TLSv1.0", "TLSv1.1", "TLSv1.2"]
  tags = {
    Created = "TF"
    For     = "example"
  }
}