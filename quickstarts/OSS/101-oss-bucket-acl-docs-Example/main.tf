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
    # When you use `alicloud_oss_bucket_acl`, you must add `ignore_changes` for the `acl` attribute
    # on `alicloud_oss_bucket` to avoid unexpected diffs caused by both resources managing the same configuration.
    ignore_changes = [
      acl,
    ]
  }
}

resource "alicloud_oss_bucket_acl" "default" {
  bucket = alicloud_oss_bucket.CreateBucket.bucket
  acl    = "private"
}