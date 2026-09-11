variable "name" {
  default = "terraform-example"
}

variable "cluster_id" {
  description = "The ID of an existing ACK cluster used as the gateway service source"
  type        = string
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.0.0.0/8"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  vpc_id       = alicloud_vpc.default.id
  zone_id      = "cn-hangzhou-i"
  cidr_block   = "10.0.0.0/24"
}

resource "alicloud_apig_gateway" "default" {
  gateway_name    = var.name
  spec            = "apigw.small.x1"
  gateway_edition = "Professional"
  gateway_type    = "API"
  payment_type    = "PayAsYouGo"
  vpc {
    vpc_id = alicloud_vpc.default.id
  }
  vswitch {
    vswitch_id = alicloud_vswitch.default.id
  }
  network_access_config {
    type = "Internet"
  }
  zone_config {
    select_option = "Auto"
  }
  log_config {
    sls {
      enable = false
    }
  }
}

resource "alicloud_apig_source" "default" {
  type       = "K8S"
  gateway_id = alicloud_apig_gateway.default.id
  k8s_source_info {
    cluster_id = var.cluster_id
  }
}