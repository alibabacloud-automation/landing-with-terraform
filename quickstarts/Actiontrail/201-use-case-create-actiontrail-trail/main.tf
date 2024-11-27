variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region = var.region
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_account" "example" {}

# 日志Project
resource "alicloud_log_project" "example" {
  project_name = "project-name-${random_integer.default.result}"
  description  = "tf actiontrail example"
}

# 创建日志Project后需初始化，一般不超过60秒
resource "time_sleep" "example" {
  depends_on      = [alicloud_log_project.example]
  create_duration = "60s"
}

data "alicloud_ram_roles" "example" {
  name_regex = "AliyunServiceRoleForActionTrail"
}

# 跟踪
resource "alicloud_actiontrail_trail" "example" {
  depends_on         = [time_sleep.example]
  trail_name         = "trail_name_${random_integer.default.result}"
  sls_write_role_arn = data.alicloud_ram_roles.example.roles.0.arn
  sls_project_arn    = "acs:log:${var.region}:${data.alicloud_account.example.id}:project/${alicloud_log_project.example.project_name}"
}