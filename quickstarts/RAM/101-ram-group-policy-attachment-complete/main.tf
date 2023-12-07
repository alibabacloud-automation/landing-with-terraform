
resource "alicloud_ram_policy" "default" {
  name        = var.name
  document    = <<EOF
		{
		  "Statement": [
			{
			  "Action": [
				"oss:ListObjects",
				"oss:ListObjects"
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
  description = "this is a policy test"
  force       = true
}

resource "alicloud_ram_group" "default" {
  name     = var.name
  comments = "group comments"
  force    = true
}

resource "alicloud_ram_group_policy_attachment" "default" {
  group_name  = alicloud_ram_group.default.name
  policy_name = alicloud_ram_policy.default.name
  policy_type = alicloud_ram_policy.default.type
}
