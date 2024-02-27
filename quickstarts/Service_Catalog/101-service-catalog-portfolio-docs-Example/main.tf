provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf_example"
}
resource "alicloud_service_catalog_portfolio" "default" {
  portfolio_name = var.name
  provider_name  = var.name
}