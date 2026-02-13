variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = ""
}

resource "alicloud_oss_bucket" "defaultrdrM3m" {
  storage_class = "Standard"
}


resource "alicloud_oss_bucket_overwrite_config" "default" {
  bucket = alicloud_oss_bucket.defaultrdrM3m.id
  rule {
    id     = "rule1"
    action = "forbid"
    prefix = "rule1-prefix/"
    suffix = "rule1-suffix/"
    principals {
      principal = ["a", "b", "c"]
    }
  }
  rule {
    id     = "rule2"
    action = "forbid"
    prefix = "rule2-prefix/"
    suffix = "rule2-suffix/"
    principals {
      principal = ["d", "e", "f"]
    }
  }
  rule {
    id     = "rule3"
    action = "forbid"
    prefix = "rule3-prefix/"
    suffix = "rule3-suffix/"
    principals {
      principal = ["1", "2", "3"]
    }
  }
}