variable "name" {
  default = "terraform-example"
}
resource "alicloud_cr_namespace" "example" {
  name               = var.name
  auto_create        = false
  default_visibility = "PUBLIC"
}