resource "alicloud_ram_user" "user" {
  name         = "terrafrom_user_test"
  display_name = "TestAccount"
  mobile       = "86-18688888888"
  email        = "example@example.com"
  comments     = "Terrafrom create"
  force        = true
}

resource "alicloud_ram_login_profile" "profile" {
  user_name = alicloud_ram_user.user.name
  password  = "!Test@123456"
}

resource "alicloud_ram_access_key" "ak" {
  user_name   = alicloud_ram_user.user.name
  secret_file = "accesskey.txt"
}

resource "alicloud_ram_policy" "policy" {
  policy_name     = "tf-example-policy"
  policy_document = <<EOF
  {
    "Statement": [
      {
        "Action": "ecs:*",
        "Effect": "Allow",
        "Resource":"*"
      }
    ],
      "Version": "1"
  }
  EOF
  description     = "this is a policy test"
}

resource "alicloud_ram_user_policy_attachment" "attach" {
  policy_name = alicloud_ram_policy.policy.policy_name
  policy_type = alicloud_ram_policy.policy.type
  user_name   = alicloud_ram_user.user.name
}