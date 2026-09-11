variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_oss_bucket" "CreateBucket" {
  storage_class = "Standard"
  bucket        = "resource-example-logging-806"
  lifecycle {
    # When you use `alicloud_oss_bucket_logging`, you must explicitly ignore the `logging` attribute on the `alicloud_oss_bucket` that logging is enabled for.
    # Otherwise `alicloud_oss_bucket` detects the logging configuration set by this resource as drift and disables it on every apply.
    ignore_changes = [logging]
  }
}

resource "alicloud_oss_bucket" "CreateLoggingBucket" {
  storage_class = "Standard"
  bucket        = "resource-example-logging-153"
}


resource "alicloud_oss_bucket_logging" "default" {
  bucket        = alicloud_oss_bucket.CreateBucket.id
  target_bucket = alicloud_oss_bucket.CreateLoggingBucket.id
  target_prefix = "log/"
  logging_role  = "example-role"
}