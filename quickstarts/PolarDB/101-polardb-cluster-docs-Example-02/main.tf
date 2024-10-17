data "alicloud_account" "current" {
}

data "alicloud_ram_roles" "roles" {
  name_regex = "AliyunRDSInstanceEncryptionDefaultRole"
}

resource "alicloud_ram_role" "default" {
  count       = length(data.alicloud_ram_roles.roles.roles) > 0 ? 0 : 1
  name        = "AliyunRDSInstanceEncryptionDefaultRole"
  document    = <<DEFINITION
    {
        "Statement": [
            {
               "Action": "sts:AssumeRole",
                "Effect": "Allow",
                "Principal": {
                    "Service": [
                        "rds.aliyuncs.com"
                    ]
                }
            }
        ],
        "Version": "1"
    }
	DEFINITION
  description = "RDS使用此角色来访问您在其他云产品中的资源"
}

resource "alicloud_resource_manager_policy_attachment" "default" {
  count             = length(data.alicloud_ram_roles.roles.roles) > 0 ? 0 : 1
  policy_name       = "AliyunRDSInstanceEncryptionRolePolicy"
  policy_type       = "System"
  principal_name    = length(data.alicloud_ram_roles.roles.roles) > 0 ? "${data.alicloud_ram_roles.roles.roles.0.name}@role.${data.alicloud_account.current.id}.onaliyunservice.com" : "${alicloud_ram_role.default[0].name}@role.${data.alicloud_account.current.id}.onaliyunservice.com"
  principal_type    = "ServiceRole"
  resource_group_id = data.alicloud_account.current.id
}