variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_oss_bucket" "defaulthNMfIF" {
  storage_class = "Standard"
}


resource "alicloud_oss_bucket_worm" "default" {
  bucket                   = alicloud_oss_bucket.defaulthNMfIF.bucket
  retention_period_in_days = "1"
  status                   = "InProgress"
}