data "alicloud_resource_manager_resource_groups" "example" {
  status = "OK"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_hbr_vault" "example" {
  vault_name = "terraform-example-${random_integer.default.result}"
}

resource "alicloud_hbr_hana_instance" "example" {
  alert_setting        = "INHERITED"
  hana_name            = "terraform-example-${random_integer.default.result}"
  host                 = "1.1.1.1"
  instance_number      = 1
  password             = "YouPassword123"
  resource_group_id    = data.alicloud_resource_manager_resource_groups.example.groups.0.id
  sid                  = "HXE"
  use_ssl              = false
  user_name            = "admin"
  validate_certificate = false
  vault_id             = alicloud_hbr_vault.example.id
}

resource "alicloud_hbr_hana_backup_plan" "example" {
  backup_prefix     = "DIFF_DATA_BACKUP"
  backup_type       = "COMPLETE"
  cluster_id        = alicloud_hbr_hana_instance.example.hana_instance_id
  database_name     = "SYSTEMDB"
  plan_name         = "terraform-example"
  resource_group_id = data.alicloud_resource_manager_resource_groups.example.groups.0.id
  schedule          = "I|1602673264|P1D"
  vault_id          = alicloud_hbr_hana_instance.example.vault_id
}