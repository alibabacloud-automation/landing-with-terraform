variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_oss_bucket" "CreateBucket" {
  storage_class = "Standard"
  bucket        = "${var.name}-${random_integer.default.result}"
}


resource "alicloud_oss_bucket_https_config" "default" {
  tls_versions = ["TLSv1.2"]
  bucket       = alicloud_oss_bucket.CreateBucket.bucket
  enable       = true
}