variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}


resource "alicloud_rds_custom_deployment_set" "default" {
  on_unable_to_redeploy_failed_instance = "CancelMembershipAndStart"
  custom_deployment_set_name            = var.name
  description                           = "2024:11:19 1010:1111:0808"
  group_count                           = "3"
  strategy                              = "Availability"
}