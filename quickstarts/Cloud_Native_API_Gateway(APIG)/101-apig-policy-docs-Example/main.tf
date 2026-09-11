variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "default" {
  vpc_name   = "${var.name}-vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = "${var.name}-vsw"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = "cn-hangzhou-b"
  cidr_block   = "192.168.15.0/24"
}

resource "alicloud_apig_gateway" "default" {
  gateway_name = "${var.name}-gw"
  gateway_type = "API"
  payment_type = "PayAsYouGo"
  spec         = "apigw.small.x1"
  network_access_config {
    type = "Intranet"
  }
  vpc {
    vpc_id = alicloud_vpc.default.id
  }
  vswitch {
    vswitch_id = alicloud_vswitch.default.id
  }
  zone_config {
    select_option = "Auto"
  }
}

resource "alicloud_apig_service" "default" {
  service_name = "${var.name}-svc"
  source_type  = "DNS"
  gateway_id   = alicloud_apig_gateway.default.id
  addresses    = ["httpbin.org:8080"]
}

resource "alicloud_apig_policy" "default" {
  policy_name          = var.name
  policy_class_name    = "ServiceTls"
  policy_config        = "{\"mode\":\"SIMPLE\",\"sni\":\"aaaa\",\"enable\":true}"
  gateway_id           = alicloud_apig_gateway.default.id
  environment_id       = alicloud_apig_gateway.default.environments.0.environment_id
  attach_resource_type = "GatewayService"
  attach_resource_ids  = [alicloud_apig_service.default.id]
}