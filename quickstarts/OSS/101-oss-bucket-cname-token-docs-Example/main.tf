variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_oss_bucket" "defaultWWM58I" {
  bucket        = var.name
  storage_class = "Standard"
}


resource "alicloud_oss_bucket_cname_token" "default" {
  bucket = alicloud_oss_bucket.defaultWWM58I.bucket
  domain = "dinary.top"
}