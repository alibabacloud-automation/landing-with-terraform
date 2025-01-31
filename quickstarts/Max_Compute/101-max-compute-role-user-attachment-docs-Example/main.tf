variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "aliyun_user" {
  default = "ALIYUN$openapiautomation@test.aliyunid.com"
}

variable "ram_user" {
  default = "RAM$openapiautomation@test.aliyunid.com:tf-example"
}

variable "ram_role" {
  default = "RAM$openapiautomation@test.aliyunid.com:role/terraform-no-ak-assumerole-no-deleting"
}

variable "role_name" {
  default = "role_project_admin"
}

variable "project_name" {
  default = "default_project_669886c"
}

resource "alicloud_max_compute_role_user_attachment" "default" {
  role_name    = var.role_name
  user         = var.ram_role
  project_name = var.project_name
}