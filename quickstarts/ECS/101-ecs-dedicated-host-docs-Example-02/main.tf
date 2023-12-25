resource "alicloud_ecs_dedicated_host" "example" {
  dedicated_host_type = "ddh.g5"
  tags = {
    Create = "Terraform",
    For    = "DDH",
  }
  description         = "terraform-example"
  dedicated_host_name = "terraform-example"
  payment_type        = "PrePaid"
  expired_time        = 1
  sale_cycle          = "Month"
}