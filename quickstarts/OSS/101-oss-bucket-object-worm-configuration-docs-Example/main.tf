variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = ""
}

resource "alicloud_oss_bucket" "defaultQf8G0L" {
  storage_class = "Standard"
}

resource "alicloud_oss_bucket_versioning" "defaultosxikW" {
  status = "Enabled"
  bucket = alicloud_oss_bucket.defaultQf8G0L.id
}


resource "alicloud_oss_bucket_object_worm_configuration" "default" {
  bucket_name         = alicloud_oss_bucket.defaultQf8G0L.id
  object_worm_enabled = "Enabled"
  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = "1"
    }
  }
}