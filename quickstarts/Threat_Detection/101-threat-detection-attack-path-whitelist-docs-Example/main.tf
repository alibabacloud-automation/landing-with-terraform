variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_threat_detection_attack_path_whitelist" "default" {
  path_type      = "role_escalation"
  whitelist_type = "PART_ASSET"
  whitelist_name = "example-1"
  path_name      = "ecs_get_credential_by_create_login_profile"
  remark         = "example-1"
  attack_path_asset_list {
    instance_id    = "AliyunYundunSASReadOnlyAccess::System"
    region_id      = "cn-hangzhou"
    vendor         = 0
    asset_type     = 15
    asset_sub_type = 2
    node_type      = "end"
  }
}