resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "bucket-referer" {
  bucket = "example-value-${random_integer.default.result}"
  acl    = "private"
  referer_config {
    allow_empty = false
    referers    = ["http://www.aliyun.com", "https://www.aliyun.com"]
  }
}