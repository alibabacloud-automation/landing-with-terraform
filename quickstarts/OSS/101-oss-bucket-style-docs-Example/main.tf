variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_oss_bucket" "CreateBucket" {
  storage_class = "Standard"
  bucket        = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_oss_bucket_style" "default" {
  bucket     = alicloud_oss_bucket.CreateBucket.id
  style_name = "style-933"
  content    = "image/resize,p_75,w_75"
  category   = "document"
}