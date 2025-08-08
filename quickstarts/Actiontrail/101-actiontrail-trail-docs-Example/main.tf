variable "name" {
  default = "terraform-example"
}

data "alicloud_regions" "default" {
  current = true
}

data "alicloud_account" "default" {
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_log_project" "default" {
  project_name = "${var.name}-${random_integer.default.result}"
  description  = "tf actiontrail example"
}

data "alicloud_ram_roles" "default" {
  name_regex = "AliyunServiceRoleForActionTrail"
}

resource "alicloud_actiontrail_trail" "default" {
  trail_name         = var.name
  sls_write_role_arn = data.alicloud_ram_roles.default.roles.0.arn
  sls_project_arn    = "acs:log:${data.alicloud_regions.default.regions.0.id}:${data.alicloud_account.default.id}:project/${alicloud_log_project.default.project_name}"
}