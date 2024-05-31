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
}


resource "alicloud_oss_bucket_user_defined_log_fields" "default" {
  bucket     = alicloud_oss_bucket.CreateBucket.bucket
  param_set  = ["oss-example", "example-para", "abc"]
  header_set = ["def", "example-header"]
}