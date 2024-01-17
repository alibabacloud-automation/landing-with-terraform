variable "name" {
  default = "tf-example"
}
data "alicloud_regions" "example" {
  current = true
}
data "alicloud_account" "example" {}

resource "alicloud_log_project" "example" {
  name        = var.name
  description = "tf actiontrail example"
}

data "alicloud_ram_roles" "example" {
  name_regex = "AliyunServiceRoleForActionTrail"
}

resource "alicloud_actiontrail_trail" "example" {
  trail_name         = var.name
  sls_write_role_arn = data.alicloud_ram_roles.example.roles.0.arn
  sls_project_arn    = "acs:log:${data.alicloud_regions.example.regions.0.id}:${data.alicloud_account.example.id}:project/${alicloud_log_project.example.name}"
}