variable "name" {
  default = "tf-example"
}
provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_regions" "default" {
  current = true
}

data "alicloud_account" "default" {}

data "alicloud_ram_roles" "default" {
  name_regex = "AliyunServiceRoleForActionTrail"
}

resource "alicloud_log_project" "default" {
  description  = var.name
  project_name = var.name
}

resource "alicloud_actiontrail_trail" "default" {
  event_rw                = "Write"
  sls_project_arn         = "acs:log:${data.alicloud_regions.default.regions.0.id}:${data.alicloud_account.default.id}:project/${alicloud_log_project.default.project_name}"
  trail_name              = var.name
  sls_write_role_arn      = data.alicloud_ram_roles.default.roles.0.arn
  trail_region            = "All"
  is_organization_trail   = false
  status                  = "Enable"
  event_selectors         = jsonencode([{ "ServiceName" : "PDS" }])
  data_event_trail_region = "cn-hangzhou"
}


resource "alicloud_actiontrail_history_delivery_job" "default" {
  trail_name = alicloud_actiontrail_trail.default.id
}