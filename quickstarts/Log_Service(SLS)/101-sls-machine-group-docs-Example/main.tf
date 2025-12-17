variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-nanjing"
}

variable "project_name" {
  default = "project-for-machine-group-terraform"
}

resource "alicloud_log_project" "defaultyJqrue" {
  description = "for terraform example"
  name        = var.project_name
}


resource "alicloud_sls_machine_group" "default" {
  group_name            = "group1"
  project_name          = var.project_name
  machine_identify_type = "ip"
  group_attribute {
    group_topic   = "example"
    external_name = "example"
  }
  machine_list = ["192.168.1.1"]
}