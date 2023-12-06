variable "name" {
  default = "tfexample"
}
data "alicloud_account" "default" {}

resource "alicloud_resource_manager_role" "example" {
  role_name                   = var.name
  assume_role_policy_document = <<EOF
     {
          "Statement": [
               {
                    "Action": "sts:AssumeRole",
                    "Effect": "Allow",
                    "Principal": {
                        "RAM":[
                                "acs:ram::${data.alicloud_account.default.id}:root"
                        ]
                    }
                }
          ],
          "Version": "1"
     }
	 EOF
}
