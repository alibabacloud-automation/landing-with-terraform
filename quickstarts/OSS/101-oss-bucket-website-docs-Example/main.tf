variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_uuid" "default" {
}

resource "alicloud_oss_bucket" "defaultnVj9x3" {
  bucket        = "${var.name}-${random_uuid.default.result}"
  storage_class = "Standard"
  lifecycle {
    ignore_changes = [website]
  }
}

resource "alicloud_oss_bucket_website" "default" {
  index_document {
    suffix          = "index.html"
    support_sub_dir = "true"
    type            = "0"
  }

  error_document {
    key         = "error.html"
    http_status = "404"
  }

  bucket = alicloud_oss_bucket.defaultnVj9x3.bucket
  routing_rules {
    routing_rule {
      rule_number = "1"
      condition {
        http_error_code_returned_equals = "404"
      }

      redirect {
        protocol           = "https"
        http_redirect_code = "305"
        redirect_type      = "AliCDN"
        host_name          = "www.alicdn-master.com"
      }

      lua_config {
        script = "example.lua"
      }

    }
  }
}