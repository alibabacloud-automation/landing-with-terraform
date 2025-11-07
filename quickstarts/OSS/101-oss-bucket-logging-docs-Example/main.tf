variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_oss_bucket" "CreateBucket" {
  storage_class = "Standard"
  bucket        = "resource-example-logging-806"
}

resource "alicloud_oss_bucket" "CreateLoggingBucket" {
  storage_class = "Standard"
  bucket        = "resource-example-logging-153"
  lifecycle {
    # When you use `alicloud_oss_bucket_logging`, you must explicitly ignore the `logging` attribute on the `alicloud_oss_bucket`.
    ignore_changes = [logging]
  }
}


resource "alicloud_oss_bucket_logging" "default" {
  bucket        = alicloud_oss_bucket.CreateBucket.id
  target_bucket = alicloud_oss_bucket.CreateBucket.id
  target_prefix = "log/"
  logging_role  = "example-role"
}