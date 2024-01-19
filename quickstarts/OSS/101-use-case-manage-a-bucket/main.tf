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
  acl    = "public-read"
}