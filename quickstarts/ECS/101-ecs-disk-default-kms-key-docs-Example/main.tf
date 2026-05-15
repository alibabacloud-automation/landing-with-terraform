variable "name" {
  default = "terraform-example"
}

data "alicloud_kms_keys" "default" {
  filters = "[{\"Key\":\"KeyState\",\"Values\":[\"Enabled\"]}]"
}

resource "alicloud_ecs_disk_default_kms_key" "default" {
  kms_key_id = data.alicloud_kms_keys.default.ids.0
}