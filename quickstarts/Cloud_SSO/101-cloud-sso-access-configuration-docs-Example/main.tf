variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

data "alicloud_cloud_sso_directories" "default" {
}

resource "alicloud_cloud_sso_access_configuration" "default" {
  directory_id              = data.alicloud_cloud_sso_directories.default.directories.0.id
  access_configuration_name = var.name
  permission_policies {
    permission_policy_type     = "Inline"
    permission_policy_name     = var.name
    permission_policy_document = <<EOF
    {
        "Statement":[
      {
        "Action":"ecs:Get*",
        "Effect":"Allow",
        "Resource":[
            "*"
        ]
      }
      ],
        "Version": "1"
    }
    EOF
  }
}