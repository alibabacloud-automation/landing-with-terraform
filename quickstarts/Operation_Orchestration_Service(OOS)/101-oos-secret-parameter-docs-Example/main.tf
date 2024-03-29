data "alicloud_resource_manager_resource_groups" "example" {}

resource "alicloud_kms_key" "example" {
  description            = "terraform-example"
  status                 = "Enabled"
  pending_window_in_days = 7
}

resource "alicloud_oos_secret_parameter" "example" {
  secret_parameter_name = "terraform-example"
  value                 = "terraform-example"
  type                  = "Secret"
  key_id                = alicloud_kms_key.example.id
  description           = "terraform-example"
  tags = {
    Created = "TF"
    For     = "OosSecretParameter"
  }
  resource_group_id = data.alicloud_resource_manager_resource_groups.example.groups.0.id
}