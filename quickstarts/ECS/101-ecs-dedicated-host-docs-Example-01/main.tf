resource "alicloud_ecs_dedicated_host" "default" {
  dedicated_host_type = "ddh.g6"
  tags = {
    Create = "Terraform",
    For    = "DDH",
  }
  description         = "From_Terraform"
  dedicated_host_name = "dedicated_host_name"
}