resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "bucket-policy" {
  bucket = "example-policy-${random_integer.default.result}"

  policy = <<POLICY
  {"Statement":
      [{"Action":
          ["oss:PutObject", "oss:GetObject", "oss:DeleteBucket"],
        "Effect":"Allow",
        "Resource":
            ["acs:oss:*:*:*"]}],
   "Version":"1"}
  POLICY
}

resource "alicloud_oss_bucket_acl" "default" {
  bucket = alicloud_oss_bucket.bucket-policy.bucket
  acl    = "private"
}