variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_oss_bucket" "CreateBucket" {
  storage_class = "Standard"
  bucket        = var.name
}


resource "alicloud_oss_bucket_acl" "default" {
  bucket = alicloud_oss_bucket.CreateBucket.bucket
  acl    = "private"
}