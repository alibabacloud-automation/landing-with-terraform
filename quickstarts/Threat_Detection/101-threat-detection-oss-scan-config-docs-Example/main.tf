variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

locals {
  bucket_random = random_integer.default.result
}

resource "alicloud_oss_bucket" "default8j4t1R" {
  bucket        = "${var.name}-1-${local.bucket_random}"
  storage_class = "Standard"
}

resource "alicloud_oss_bucket" "default9HMqfT" {
  bucket        = "${var.name}-2-${local.bucket_random}"
  storage_class = "Standard"
}

resource "alicloud_oss_bucket" "defaultxBXqFQ" {
  bucket        = "${var.name}-3-${local.bucket_random}"
  storage_class = "Standard"
}

resource "alicloud_oss_bucket" "defaulthZvCmR" {
  bucket        = "${var.name}-4-${local.bucket_random}"
  storage_class = "Standard"
}

resource "alicloud_threat_detection_oss_scan_config" "default" {
  key_suffix_list = [
    ".jsp",
    ".php",
    ".k"
  ]
  scan_day_list = [
    "2",
    "5",
    "4",
    "3"
  ]
  oss_scan_config_name = var.name
  end_time             = "00:00:02"
  start_time           = "00:00:01"
  enable               = "1"
  all_key_prefix       = "false"
  bucket_name_list = [
    alicloud_oss_bucket.default8j4t1R.bucket,
    alicloud_oss_bucket.default9HMqfT.bucket,
    alicloud_oss_bucket.defaultxBXqFQ.bucket
  ]
  key_prefix_list = [
    "/root",
    "/usr",
    "/123"
  ]
}