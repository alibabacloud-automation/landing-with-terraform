resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "bucket-sserule" {
  bucket = "terraform-example-${random_integer.default.result}"

  server_side_encryption_rule {
    sse_algorithm = "AES256"
  }
}

resource "alicloud_oss_bucket_acl" "bucket-kms" {
  bucket = alicloud_oss_bucket.bucket-sserule.bucket
  acl    = "private"
}

resource "alicloud_kms_key" "kms" {
  description            = "terraform-example"
  pending_window_in_days = "7"
  status                 = "Enabled"
}

resource "alicloud_oss_bucket" "bucket-kms" {
  bucket = "terraform-example-kms-${random_integer.default.result}"

  server_side_encryption_rule {
    sse_algorithm     = "KMS"
    kms_master_key_id = alicloud_kms_key.kms.id
  }
}

resource "alicloud_oss_bucket_acl" "bucket-kms" {
  bucket = alicloud_oss_bucket.bucket-kms.bucket
  acl    = "private"
}