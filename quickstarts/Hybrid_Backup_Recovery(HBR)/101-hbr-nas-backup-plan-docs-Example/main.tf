resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_hbr_vault" "default" {
  vault_name = "terraform-example-${random_integer.default.result}"
}

resource "alicloud_nas_file_system" "default" {
  protocol_type = "NFS"
  storage_type  = "Performance"
  description   = "terraform-example"
  encrypt_type  = "1"
}

resource "alicloud_hbr_nas_backup_plan" "default" {
  nas_backup_plan_name = "terraform-example"
  file_system_id       = alicloud_nas_file_system.default.id
  schedule             = "I|1602673264|PT2H"
  backup_type          = "COMPLETE"
  vault_id             = alicloud_hbr_vault.default.id
  retention            = "2"
  path                 = ["/"]
}