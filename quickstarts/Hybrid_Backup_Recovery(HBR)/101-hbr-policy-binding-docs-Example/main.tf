variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_hbr_vault" "defaultyk84Hc" {
  vault_type = "STANDARD"
  vault_name = "example-value-${random_integer.default.result}"
}

resource "alicloud_hbr_policy" "defaultoqWvHQ" {
  policy_name = "example-value-${random_integer.default.result}"
  rules {
    rule_type    = "BACKUP"
    backup_type  = "COMPLETE"
    schedule     = "I|1631685600|P1D"
    retention    = "7"
    archive_days = "0"
    vault_id     = alicloud_hbr_vault.defaultyk84Hc.id
  }
  policy_description = "policy example"
}

resource "alicloud_oss_bucket" "defaultKtt2XY" {
  storage_class = "Standard"
  bucket        = "example-value-${random_integer.default.result}"
}

resource "alicloud_hbr_policy_binding" "default" {
  source_type                = "OSS"
  disabled                   = "false"
  policy_id                  = alicloud_hbr_policy.defaultoqWvHQ.id
  data_source_id             = alicloud_oss_bucket.defaultKtt2XY.bucket
  policy_binding_description = "policy binding example (update)"
  source                     = "prefix-example-update/"
}