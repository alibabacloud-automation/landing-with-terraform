variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_service_catalog_product" "default" {
  provider_name = var.name
  description   = "desc"
  product_name  = var.name
  product_type  = "Ros"
}