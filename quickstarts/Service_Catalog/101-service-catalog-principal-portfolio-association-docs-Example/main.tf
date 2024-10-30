variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_service_catalog_portfolio" "defaultDaXVxI" {
  provider_name  = var.name
  description    = "desc"
  portfolio_name = var.name
}

resource "alicloud_ram_role" "default48JHf4" {
  name        = var.name
  document    = <<EOF
    {
        "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
            "Service": [
                "emr.aliyuncs.com",
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


resource "alicloud_service_catalog_principal_portfolio_association" "default" {
  principal_id   = alicloud_ram_role.default48JHf4.id
  portfolio_id   = alicloud_service_catalog_portfolio.defaultDaXVxI.id
  principal_type = "RamRole"
}