variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_cr_ee_instance" "default" {
  default_oss_bucket = "true"
  instance_name      = var.name
  renewal_status     = "ManualRenewal"
  image_scanner      = "DISABLE"
  period             = "1"
  payment_type       = "Subscription"
  instance_type      = "Economy"
}

resource "alicloud_cr_ee_namespace" "default" {
  instance_id        = alicloud_cr_ee_instance.default.id
  name               = var.name
  auto_create        = false
  default_visibility = "PRIVATE"
}

resource "alicloud_cr_ee_repo" "default" {
  instance_id = alicloud_cr_ee_instance.default.id
  namespace   = alicloud_cr_ee_namespace.default.name
  name        = var.name
  repo_type   = "PRIVATE"
  summary     = "example repository for lifecycle rule"
}

resource "alicloud_cr_artifact_lifecycle_rule" "default" {
  auto                = true
  namespace_name      = alicloud_cr_ee_namespace.default.name
  retention_tag_count = "30"
  schedule_time       = "WEEK"
  scope               = "REPO"
  instance_id         = alicloud_cr_ee_instance.default.id
  tag_regexp          = ".*"
  repo_name           = alicloud_cr_ee_repo.default.name
}