variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_oss_bucket" "CreateBucket" {
  bucket        = var.name
  storage_class = "Standard"
}

resource "alicloud_oss_bucket_cname_token" "defaultZaWJfG" {
  bucket = alicloud_oss_bucket.CreateBucket.bucket
  domain = "tftestacc.com"
}

resource "alicloud_alidns_record" "defaultnHqm5p" {
  status      = "ENABLE"
  line        = "default"
  rr          = "_dnsauth"
  type        = "TXT"
  domain_name = "tftestacc.com"
  priority    = "1"
  value       = alicloud_oss_bucket_cname_token.defaultZaWJfG.token
  ttl         = "600"
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "alicloud_oss_bucket_cname" "default" {
  bucket = alicloud_oss_bucket.CreateBucket.bucket
  domain = alicloud_alidns_record.defaultnHqm5p.domain_name
}