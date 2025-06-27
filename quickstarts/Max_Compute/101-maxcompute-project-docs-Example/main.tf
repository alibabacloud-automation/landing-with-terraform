variable "name" {
  default = "tf_example"
}
resource "alicloud_maxcompute_project" "default" {
  default_quota = "os_PayAsYouGoQuota"
  project_name  = var.name
  comment       = var.name
}