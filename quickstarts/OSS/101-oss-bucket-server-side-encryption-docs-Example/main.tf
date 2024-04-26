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
    ignore_changes = [
      server_side_encryption_rule,
    ]
  }
}

resource "alicloud_kms_key" "GetKMS" {
  origin                 = "Aliyun_KMS"
  protection_level       = "SOFTWARE"
  description            = var.name
  key_spec               = "Aliyun_AES_256"
  key_usage              = "ENCRYPT/DECRYPT"
  automatic_rotation     = "Disabled"
  pending_window_in_days = 7
}


resource "alicloud_oss_bucket_server_side_encryption" "default" {
  kms_data_encryption = "SM4"
  kms_master_key_id   = alicloud_kms_key.GetKMS.id
  bucket              = alicloud_oss_bucket.CreateBucket.bucket
  sse_algorithm       = "KMS"
}