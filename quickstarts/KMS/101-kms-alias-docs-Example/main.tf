resource "alicloud_kms_key" "this" {
  pending_window_in_days = 7
}

resource "alicloud_kms_alias" "this" {
  alias_name = "alias/example_kms_alias"
  key_id     = alicloud_kms_key.this.id
}