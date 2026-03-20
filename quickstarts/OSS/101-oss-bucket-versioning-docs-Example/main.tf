variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_oss_bucket" "CreateBucket" {
  storage_class = "Standard"
  bucket        = "${var.name}-${random_integer.default.result}"
  lifecycle {
    # When you use `alicloud_oss_bucket_versioning`, you must add `ignore_changes` for the `versioning` attribute
    # on `alicloud_oss_bucket` to avoid unexpected diffs caused by both resources managing the same configuration.
    ignore_changes = [
      versioning,
    ]
  }
}


resource "alicloud_oss_bucket_versioning" "default" {
  status = "Enabled"
  bucket = alicloud_oss_bucket.CreateBucket.bucket
}