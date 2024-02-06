provider "alicloud" {
  region = "cn-hangzhou"
}
resource "random_integer" "default" {
  max = 99999
  min = 10000
}
resource "alicloud_oss_bucket" "default" {
  bucket = "terraform-example-${random_integer.default.result}"
}
# If you upload the function by OSS Bucket, you need to specify path can't upload by content.
resource "alicloud_oss_bucket_object" "default" {
  bucket  = alicloud_oss_bucket.default.id
  key     = "index.py"
  content = "import logging \ndef handler(event, context): \nlogger = logging.getLogger() \nlogger.info('hello world') \nreturn 'hello world'"
}

resource "alicloud_fc_layer_version" "example" {
  layer_name         = "terraform-example-${random_integer.default.result}"
  compatible_runtime = ["python2.7"]
  oss_bucket_name    = alicloud_oss_bucket.default.bucket
  oss_object_name    = alicloud_oss_bucket_object.default.key
}