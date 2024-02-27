data "alicloud_account" "default" {}

resource "alicloud_log_audit" "example" {
  display_name = "tf-audit-example"
  aliuid       = data.alicloud_account.default.id
  variable_map = {
    "actiontrail_enabled" = "true",
    "actiontrail_ttl"     = "180",
    "oss_access_enabled"  = "true",
    "oss_access_ttl"      = "180",
  }
  multi_account = ["123456789123", "12345678912300123"]
}