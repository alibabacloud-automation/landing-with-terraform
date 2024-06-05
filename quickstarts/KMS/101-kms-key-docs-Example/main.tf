resource "alicloud_kms_key" "default" {
  description            = "Hello KMS"
  status                 = "Enabled"
  pending_window_in_days = "7"
}