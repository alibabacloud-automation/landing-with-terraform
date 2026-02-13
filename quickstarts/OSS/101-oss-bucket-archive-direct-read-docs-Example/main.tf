variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = ""
}

resource "alicloud_oss_bucket" "CreateBucket" {
  storage_class = "Standard"
}


resource "alicloud_oss_bucket_archive_direct_read" "default" {
  bucket  = alicloud_oss_bucket.CreateBucket.id
  enabled = true
}