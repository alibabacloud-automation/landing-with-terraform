variable "name" {
  default = "tf_example"
}
resource "alicloud_datahub_project" "example" {
  name    = var.name
  comment = "created by terraform"
}