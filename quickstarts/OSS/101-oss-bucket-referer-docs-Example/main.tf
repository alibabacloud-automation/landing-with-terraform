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
      referer_config,
    ]
  }
}


resource "alicloud_oss_bucket_referer" "default" {
  allow_empty_referer = "true"
  referer_blacklist = [
    "*.forbidden.com"
  ]
  bucket                      = alicloud_oss_bucket.CreateBucket.bucket
  truncate_path               = "false"
  allow_truncate_query_string = "true"
  referer_list = [
    "*.aliyun.com",
    "*.example.com"
  ]
}