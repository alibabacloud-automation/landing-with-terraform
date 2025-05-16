variable "admin_code" {
  default = "role_project_admin"
}

variable "name" {
  default = "tf_example"
}

provider "alicloud" {
  region = "cn-chengdu"
}

resource "random_integer" "randint" {
  max = 999
  min = 1
}

resource "alicloud_ram_user" "defaultKCTrB2" {
  display_name = "${var.name}${random_integer.randint.id}"
  name         = "${var.name}${random_integer.randint.id}"
}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_data_works_project" "defaultQeRfvU" {
  status                  = "Available"
  description             = "tf_desc"
  project_name            = "${var.name}${random_integer.randint.id}"
  pai_task_enabled        = "false"
  display_name            = "tf_new_api_display"
  dev_role_disabled       = "true"
  dev_environment_enabled = "false"
  resource_group_id       = data.alicloud_resource_manager_resource_groups.default.ids.0
}

resource "alicloud_data_works_project_member" "default" {
  user_id    = alicloud_ram_user.defaultKCTrB2.id
  project_id = alicloud_data_works_project.defaultQeRfvU.id
  roles {
    code = var.admin_code
  }
}