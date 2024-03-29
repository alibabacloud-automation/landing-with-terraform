resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "bucket-website" {
  bucket = "example-value-${random_integer.default.result}"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}