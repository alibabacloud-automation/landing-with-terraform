resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "default" {
  bucket = "terraform-example-${random_integer.default.result}"
  acl    = "private"
}

resource "alicloud_oss_bucket_object" "default" {
  bucket = alicloud_oss_bucket.default.bucket
  key    = "example_key"
  source = "./main.tf"
}