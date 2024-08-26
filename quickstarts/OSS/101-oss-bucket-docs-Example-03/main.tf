resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "bucket-target" {
  bucket = "example-value-${random_integer.default.result}"
}

resource "alicloud_oss_bucket_acl" "bucket-target" {
  bucket = alicloud_oss_bucket.bucket-target.bucket
  acl    = "public-read"
}


resource "alicloud_oss_bucket" "bucket-logging" {
  bucket = "example-logging-${random_integer.default.result}"
  logging {
    target_bucket = alicloud_oss_bucket.bucket-target.id
    target_prefix = "log/"
  }
}