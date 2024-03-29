resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_hbr_vault" "default" {
  vault_name = "terraform-example-${random_integer.default.result}"
  vault_type = "OTS_BACKUP"
}

resource "alicloud_ots_instance" "default" {
  name        = "Example-${random_integer.default.result}"
  description = "terraform-example"
  accessed_by = "Any"
  tags = {
    Created = "TF"
    For     = "example"
  }
}

resource "alicloud_ots_table" "default" {
  instance_name = alicloud_ots_instance.default.name
  table_name    = "terraform_example"
  primary_key {
    name = "pk1"
    type = "Integer"
  }
  time_to_live                  = -1
  max_version                   = 1
  deviation_cell_version_in_sec = 1
}

resource "alicloud_ram_role" "default" {
  name     = "hbrexamplerole"
  document = <<EOF
		{
			"Statement": [
			{
				"Action": "sts:AssumeRole",
				"Effect": "Allow",
				"Principal": {
					"Service": [
						"crossbackup.hbr.aliyuncs.com"
					]
				}
			}
			],
  			"Version": "1"
		}
  		EOF
  force    = true
}

data "alicloud_account" "default" {}
resource "alicloud_hbr_ots_backup_plan" "example" {
  ots_backup_plan_name    = "terraform-example-${random_integer.default.result}"
  vault_id                = alicloud_hbr_vault.default.id
  backup_type             = "COMPLETE"
  retention               = "1"
  instance_name           = alicloud_ots_instance.default.name
  cross_account_type      = "SELF_ACCOUNT"
  cross_account_user_id   = data.alicloud_account.default.id
  cross_account_role_name = alicloud_ram_role.default.id

  ots_detail {
    table_names = [alicloud_ots_table.default.table_name]
  }
  rules {
    schedule    = "I|1602673264|PT2H"
    retention   = "1"
    disabled    = "false"
    rule_name   = "terraform-example"
    backup_type = "COMPLETE"
  }
}