variable "name" {
  default = "terraform-example"
}

resource "alicloud_ecs_deployment_set" "default" {
  strategy            = "Availability"
  deployment_set_name = var.name
  description         = var.name
}