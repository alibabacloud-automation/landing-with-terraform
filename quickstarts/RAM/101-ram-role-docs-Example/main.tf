resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ram_role" "default" {
  role_name                   = "terraform-example-${random_integer.default.result}"
  assume_role_policy_document = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "apigateway.aliyuncs.com",
            "ecs.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
  description                 = "this is a role test."
}