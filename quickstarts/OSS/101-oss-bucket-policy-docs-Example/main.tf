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
      policy,
    ]
  }
}

resource "alicloud_oss_bucket_policy" "default" {
  policy = jsonencode({ "Version" : "1", "Statement" : [{ "Action" : ["oss:PutObject", "oss:GetObject"], "Effect" : "Deny", "Principal" : ["1234567890"], "Resource" : ["acs:oss:*:1234567890:*/*"] }] })
  bucket = alicloud_oss_bucket.CreateBucket.bucket
}