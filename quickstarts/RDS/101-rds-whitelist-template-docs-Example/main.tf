resource "alicloud_rds_whitelist_template" "example" {
  ip_white_list = "172.16.0.0"
  template_name = "example-whitelist"
}