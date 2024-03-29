resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_log_project" "example_policy" {
  name        = "terraform-example-${random_integer.default.result}"
  description = "terraform-example"
  policy      = <<EOF
{
  "Statement": [
    {
      "Action": [
        "log:PostLogStoreLogs"
      ],
      "Condition": {
        "StringNotLike": {
          "acs:SourceVpc": [
            "vpc-*"
          ]
        }
      },
      "Effect": "Deny",
      "Resource": "acs:log:*:*:project/tf-log/*"
    }
  ],
  "Version": "1"
}
EOF
}