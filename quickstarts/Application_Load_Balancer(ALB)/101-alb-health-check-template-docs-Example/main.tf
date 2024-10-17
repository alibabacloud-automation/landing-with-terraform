variable "name" {
  default = "terraform-example"
}

resource "alicloud_alb_health_check_template" "example" {
  health_check_template_name = var.name
}