provider "alicloud" {
  region = "cn-hangzhou"
}
variable "kms_key_version_id" {
  default = "xxx"
}

resource "alicloud_kms_key_version" "keyversion" {
  key_id = var.kms_key_version_id
}
