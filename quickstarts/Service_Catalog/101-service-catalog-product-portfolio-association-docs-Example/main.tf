variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_service_catalog_portfolio" "default0yAgJ8" {
  provider_name  = var.name
  description    = "desc"
  portfolio_name = var.name
}

resource "alicloud_service_catalog_product" "defaultRetBJw" {
  provider_name = var.name
  product_name  = format("%s1", var.name)
  product_type  = "Ros"
}


resource "alicloud_service_catalog_product_portfolio_association" "default" {
  portfolio_id = alicloud_service_catalog_portfolio.default0yAgJ8.id
  product_id   = alicloud_service_catalog_product.defaultRetBJw.id
}