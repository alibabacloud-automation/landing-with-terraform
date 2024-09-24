variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_service_catalog_product" "defaultmaeTcE" {
  provider_name = var.name
  product_name  = var.name
  product_type  = "Ros"
}


resource "alicloud_service_catalog_product_version" "default" {
  guidance             = "Default"
  template_url         = "oss://servicecatalog-cn-hangzhou/1466115886172051/terraform/template/tpl-bp1x4v3r44u7u7/template.json"
  active               = true
  description          = "产品版本测试"
  product_version_name = var.name
  product_id           = alicloud_service_catalog_product.defaultmaeTcE.id
  template_type        = "RosTerraformTemplate"
}