variable "name" {
  default = "terraform-example"
}

data "alicloud_regions" "default" {
  current = true
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_cr_ee_instance" "source" {
  payment_type   = "Subscription"
  period         = 1
  renew_period   = 0
  renewal_status = "ManualRenewal"
  instance_type  = "Advanced"
  instance_name  = "${var.name}-source-${random_integer.default.result}"
}

resource "alicloud_cr_ee_instance" "target" {
  payment_type   = "Subscription"
  period         = 1
  renew_period   = 0
  renewal_status = "ManualRenewal"
  instance_type  = "Advanced"
  instance_name  = "${var.name}-target-${random_integer.default.result}"
}

resource "alicloud_cr_ee_namespace" "source" {
  instance_id        = alicloud_cr_ee_instance.source.id
  name               = var.name
  auto_create        = false
  default_visibility = "PUBLIC"
}

resource "alicloud_cr_ee_namespace" "target" {
  instance_id        = alicloud_cr_ee_instance.target.id
  name               = var.name
  auto_create        = false
  default_visibility = "PUBLIC"
}

resource "alicloud_cr_ee_repo" "source" {
  instance_id = alicloud_cr_ee_instance.source.id
  namespace   = alicloud_cr_ee_namespace.source.name
  name        = var.name
  summary     = "this is summary of my new repo"
  repo_type   = "PUBLIC"
}

resource "alicloud_cr_ee_repo" "target" {
  instance_id = alicloud_cr_ee_instance.target.id
  namespace   = alicloud_cr_ee_namespace.target.name
  name        = var.name
  summary     = "this is summary of my new repo"
  repo_type   = "PUBLIC"
}

resource "alicloud_cr_ee_sync_rule" "default" {
  instance_id           = alicloud_cr_ee_instance.source.id
  namespace_name        = alicloud_cr_ee_namespace.source.name
  name                  = var.name
  target_instance_id    = alicloud_cr_ee_instance.target.id
  target_namespace_name = alicloud_cr_ee_namespace.target.name
  target_region_id      = data.alicloud_regions.default.regions.0.id
  tag_filter            = ".*"
  repo_name             = alicloud_cr_ee_repo.source.name
  target_repo_name      = alicloud_cr_ee_repo.target.name
}