resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "default" {
  bucket        = "example-${random_integer.default.result}"
  storage_class = "IA"
}