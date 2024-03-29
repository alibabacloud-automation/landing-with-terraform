resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "bucket-acl" {
  bucket = "example-value-${random_integer.default.result}"
  acl    = "private"
}