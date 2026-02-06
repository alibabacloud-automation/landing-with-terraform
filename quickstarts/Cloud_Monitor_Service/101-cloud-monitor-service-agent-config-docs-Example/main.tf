variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_cloud_monitor_service_agent_config" "default" {
  enable_install_agent_new_ecs = false
}