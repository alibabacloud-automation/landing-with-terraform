variable "name" {
  default = "tfexample"
}

resource "alicloud_resource_manager_policy" "example" {
  policy_name     = var.name
  policy_document = <<EOF
		{
			"Statement": [{
				"Action": ["oss:*"],
				"Effect": "Allow",
				"Resource": ["acs:oss:*:*:*"]
			}],
			"Version": "1"
		}
    EOF
}
