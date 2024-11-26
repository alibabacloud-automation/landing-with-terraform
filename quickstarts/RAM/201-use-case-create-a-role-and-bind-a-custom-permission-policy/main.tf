resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 权限策略
resource "alicloud_ram_policy" "policy" {
  policy_name     = "policy-name-${random_integer.default.result}"
  policy_document = <<EOF
    {
      "Statement": [
        {
          "Action": [
            "oss:ListObjects",
            "oss:GetObject"
          ],
          "Effect": "Deny",
          "Resource": [
            "acs:oss:*:*:mybucket",
            "acs:oss:*:*:mybucket/*"
          ]
        }
      ],
        "Version": "1"
    }
EOF
  description     = "this is a policy test"
  force           = true
}

# RAM角色
resource "alicloud_ram_role" "role" {
  name        = "role-name-${random_integer.default.result}"
  document    = <<EOF
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
  description = "this is a role test."
  force       = true
}

# 为RAM角色授予权限
resource "alicloud_ram_role_policy_attachment" "attach" {
  policy_name = alicloud_ram_policy.policy.policy_name
  role_name   = alicloud_ram_role.role.name
  policy_type = alicloud_ram_policy.policy.type
}