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
  lifecycle {
    ignore_changes = [
      logging,
    ]
  }
}

resource "alicloud_oss_bucket_logging" "default" {
  bucket        = alicloud_oss_bucket.CreateBucket.bucket
  target_bucket = alicloud_oss_bucket.CreateBucket.bucket
  target_prefix = "log/"
}