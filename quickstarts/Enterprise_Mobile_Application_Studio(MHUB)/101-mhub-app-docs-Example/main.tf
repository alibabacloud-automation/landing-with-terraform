provider "alicloud" {
  region = "cn-shanghai"
}

variable "name" {
  default = "example_value"
}

resource "alicloud_mhub_product" "default" {
  product_name = var.name
}

resource "alicloud_mhub_app" "default" {
  app_name     = var.name
  product_id   = alicloud_mhub_product.default.id
  package_name = "com.example.android"
  type         = "Android"
}