data "alicloud_account" "current" {
}


// resource "alicloud_ram_role" "default" {
//  name        = "AliyunRDSInstanceEncryptionDefaultRole"
//  document    = <<DEFINITION
//    {
//        "Statement": [
//            {
//               "Action": "sts:AssumeRole",
//                "Effect": "Allow",
//                "Principal": {
//                    "Service": [
//                        "rds.aliyuncs.com"
//                    ]
//                }
//            }
//        ],
//        "Version": "1"
//    }
//	DEFINITION
//  description = "RDS使用此角色来访问您在其他云产品中的资源"
//}



// resource "alicloud_resource_manager_policy_attachment" "default" {
// policy_name       = "AliyunRDSInstanceEncryptionRolePolicy"
// policy_type       = "System"
// principal_name    = "AliyunRDSInstanceEncryptionDefaultRole@role.${data.alicloud_account.current.id}.onaliyunservice.com"
// principal_type    = "ServiceRole"
// resource_group_id = "${data.alicloud_account.current.id}"
// }
