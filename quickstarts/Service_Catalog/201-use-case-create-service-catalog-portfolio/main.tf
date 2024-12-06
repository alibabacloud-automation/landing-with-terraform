variable "region" {
  default = "cn-hangzhou"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "tf_example"
}
resource "alicloud_service_catalog_portfolio" "default" {
  # （可选）组合的描述
  description = "test-catalog-portfolio"
  # （必需）组合的名称
  portfolio_name = var.name
  # （必需）组合的提供者名称
  provider_name = var.name
}