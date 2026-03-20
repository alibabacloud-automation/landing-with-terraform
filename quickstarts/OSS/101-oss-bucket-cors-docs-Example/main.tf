variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_uuid" "default" {

}

resource "alicloud_oss_bucket" "CreateBucket" {
  storage_class = "Standard"
  bucket        = "${var.name}-${random_uuid.default.result}"
  lifecycle {
    # When you use `alicloud_oss_bucket_cors`, you must add `ignore_changes` for the `cors_rule` attribute
    # on `alicloud_oss_bucket` to avoid unexpected diffs caused by both resources managing the same configuration.
    ignore_changes = [
      cors_rule,
    ]
  }
}


resource "alicloud_oss_bucket_cors" "default" {
  bucket        = alicloud_oss_bucket.CreateBucket.bucket
  response_vary = true
  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    allowed_headers = ["x-oss-test", "x-oss-abc"]
    expose_header   = ["x-oss-request-id"]
    max_age_seconds = "1000"
  }
}