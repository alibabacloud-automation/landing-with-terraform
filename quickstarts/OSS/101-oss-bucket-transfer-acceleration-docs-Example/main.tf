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
      transfer_acceleration,
    ]
  }
}


resource "alicloud_oss_bucket_transfer_acceleration" "default" {
  bucket  = alicloud_oss_bucket.CreateBucket.bucket
  enabled = true
}