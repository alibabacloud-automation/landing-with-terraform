resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "bucket-versioning" {
  bucket = "terraform-example-${random_integer.default.result}"
  versioning {
    status = "Enabled"
  }
}

resource "alicloud_oss_bucket_acl" "default" {
  bucket = alicloud_oss_bucket.bucket-versioning.bucket
  acl    = "private"
}