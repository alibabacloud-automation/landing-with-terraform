provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "terraform-example"
}

variable "domain" {
  default = "com.aliyun.cn-hangzhou.oss"
}

resource "alicloud_vpc" "defaultVpc" {
  description = "tf-example"
}

resource "alicloud_resource_manager_resource_group" "defaultRg" {
  display_name        = "tf-example-497"
  resource_group_name = var.name
}

resource "alicloud_vpc_gateway_endpoint" "default" {
  gateway_endpoint_descrption = "test-gateway-endpoint"
  gateway_endpoint_name       = var.name
  vpc_id                      = alicloud_vpc.defaultVpc.id
  resource_group_id           = alicloud_resource_manager_resource_group.defaultRg.id
  service_name                = var.domain
  policy_document             = <<EOF
      {
        "Version": "1",
        "Statement": [{
          "Effect": "Allow",
          "Resource": ["*"],
          "Action": ["*"],
          "Principal": ["*"]
        }]
      }
      EOF
}