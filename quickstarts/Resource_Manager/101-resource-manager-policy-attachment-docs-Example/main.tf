variable "name" {
  default = "tfexamplename"
}

resource "alicloud_ram_user" "example" {
  name = var.name
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

data "alicloud_resource_manager_resource_groups" "example" {
  status = "OK"
}

# Get Alicloud Account Id
data "alicloud_account" "example" {}

# Attach the custom policy to resource group
resource "alicloud_resource_manager_policy_attachment" "example" {
  policy_name       = alicloud_resource_manager_policy.example.policy_name
  policy_type       = "Custom"
  principal_name    = format("%s@%s.onaliyun.com", alicloud_ram_user.example.name, data.alicloud_account.example.id)
  principal_type    = "IMSUser"
  resource_group_id = data.alicloud_resource_manager_resource_groups.example.ids.0
}
