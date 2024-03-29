variable "name" {
  default = "tf-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_regions" "example" {
  current = true
}
data "alicloud_account" "example" {}

resource "alicloud_log_project" "example" {
  project_name = "${var.name}-${random_integer.default.result}"
  description  = "tf actiontrail example"
}

data "alicloud_ram_roles" "example" {
  name_regex = "AliyunServiceRoleForActionTrail"
}

resource "alicloud_actiontrail_trail" "example" {
  trail_name         = var.name
  sls_write_role_arn = data.alicloud_ram_roles.example.roles.0.arn
  sls_project_arn    = "acs:log:${data.alicloud_regions.example.regions.0.id}:${data.alicloud_account.example.id}:project/${alicloud_log_project.example.name}"
}