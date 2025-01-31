variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_maxcompute_project" "default" {
  default_quota = "默认后付费Quota"
  project_name  = var.name
  comment       = var.name
  product_type  = "PayAsYouGo"
}

resource "alicloud_max_compute_role" "default" {
  type         = "admin"
  project_name = alicloud_maxcompute_project.default.id
  policy       = jsonencode({ "Statement" : [{ "Action" : ["odps:*"], "Effect" : "Allow", "Resource" : ["acs:odps:*:projects/project_name/authorization/roles", "acs:odps:*:projects/project_name/authorization/roles/*/*"] }], "Version" : "1" })
  role_name    = "tf_example112"
}