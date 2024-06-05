variable "name" {
  default = "terraform-example"
}

resource "alicloud_kms_secret" "default" {
  secret_name                   = var.name
  secret_data                   = "Secret data"
  version_id                    = "v1"
  force_delete_without_recovery = true
}