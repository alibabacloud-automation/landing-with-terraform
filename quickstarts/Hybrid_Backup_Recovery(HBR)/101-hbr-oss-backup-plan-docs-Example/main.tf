resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_hbr_vault" "default" {
  vault_name = "terraform-example-${random_integer.default.result}"
}

resource "alicloud_oss_bucket" "default" {
  bucket = "terraform-example-${random_integer.default.result}"
}

resource "alicloud_hbr_oss_backup_plan" "default" {
  oss_backup_plan_name = "terraform-example"
  # the prefix of object you want to back up
  prefix      = "/example"
  bucket      = alicloud_oss_bucket.default.bucket
  vault_id    = alicloud_hbr_vault.default.id
  schedule    = "I|1602673264|PT2H"
  backup_type = "COMPLETE"
  retention   = "2"
}