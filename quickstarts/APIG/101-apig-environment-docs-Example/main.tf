variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_resource_manager_resource_groups" "default" {}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}
data "alicloud_vswitches" "default" {
  vpc_id = data.alicloud_vpcs.default.ids.0
}

resource "alicloud_apig_gateway" "defaultgateway" {
  network_access_config {
    type = "Intranet"
  }
  vswitch {
    vswitch_id = data.alicloud_vswitches.default.ids.0
  }
  zone_config {
    select_option = "Auto"
  }
  vpc {
    vpc_id = data.alicloud_vpcs.default.ids.0
  }
  payment_type = "PayAsYouGo"
  gateway_name = format("%s2", var.name)
  spec         = "apigw.small.x1"
  log_config {
    sls {
    }
  }
}

resource "alicloud_apig_environment" "default" {
  description       = var.name
  environment_name  = var.name
  gateway_id        = alicloud_apig_gateway.defaultgateway.id
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.1
}