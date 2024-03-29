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

resource "alicloud_actiontrail_trail" "example" {
  trail_name      = "${var.name}-${random_integer.default.result}"
  sls_project_arn = "acs:log:${data.alicloud_regions.example.regions.0.id}:${data.alicloud_account.example.id}:project/${alicloud_log_project.example.name}"
}

resource "alicloud_actiontrail_history_delivery_job" "example" {
  trail_name = alicloud_actiontrail_trail.example.id
}