resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "example" {
  bucket = "example-sub-resources-${random_integer.default.result}"

  # When using standalone sub-resources to manage bucket configurations,
  # you must add `ignore_changes` for the corresponding attributes.
  # Otherwise, Terraform will detect a diff between the inline attribute
  # and the sub-resource, and attempt to revert the sub-resource's changes.
  lifecycle {
    ignore_changes = [
      policy,
      logging,
      website,
      cors_rule,
      versioning,
      referer_config,
      server_side_encryption_rule,
      transfer_acceleration,
    ]
  }
}

resource "alicloud_oss_bucket_acl" "example" {
  bucket = alicloud_oss_bucket.example.bucket
  acl    = "private"
}

resource "alicloud_oss_bucket_policy" "example" {
  bucket = alicloud_oss_bucket.example.bucket
  policy = jsonencode({
    "Version" : "1",
    "Statement" : [{
      "Action" : ["oss:PutObject", "oss:GetObject"],
      "Effect" : "Deny",
      "Principal" : ["1234567890"],
      "Resource" : ["acs:oss:*:1234567890:*/*"]
    }]
  })
}

resource "alicloud_oss_bucket_logging" "example" {
  bucket        = alicloud_oss_bucket.example.bucket
  target_bucket = alicloud_oss_bucket.example.bucket
  target_prefix = "log/"
}