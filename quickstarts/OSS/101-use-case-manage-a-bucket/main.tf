provider "alicloud" {
  alias  = "bj-prod"
  region = "cn-beijing"
}
resource "random_integer" "default" {
  min = 10000
  max = 99999
}
resource "alicloud_oss_bucket" "bucket-new" {
  provider = alicloud.bj-prod

  bucket = "bucket-auto-2024${random_integer.default.result}"
}

resource "alicloud_oss_bucket_acl" "bucket-new" {
  bucket = alicloud_oss_bucket.bucket-new.bucket
  acl    = "public-read"
}