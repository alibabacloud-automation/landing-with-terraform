provider "alicloud" {
  region = var.region_id
}

variable "region_id" {
  type    = string
  default = "cn-shenzhen"
}

variable "cluster_spec" {
  type        = string
  description = "The cluster specifications of kubernetes cluster,which can be empty. Valid values:ack.standard : Standard managed clusters; ack.pro.small : Professional managed clusters."
  default     = "ack.pro.small"
}

variable "k8s_name_prefix" {
  description = "The name prefix used to create ASK cluster."
  default     = "ask-example"
}

variable "ack_version" {
  type        = string
  description = "Desired Kubernetes version. "
  default     = "1.31.1-aliyun.1"
}

# 默认资源名称。
locals {
  k8s_name_ask = substr(join("-", [var.k8s_name_prefix, "ask"]), 0, 63)
  new_vpc_name = "tf-vpc-172-16"
  new_vsw_name = "tf-vswitch-172-16-0"
  new_sg_name  = "tf-sg-172-16"
}

data "alicloud_eci_zones" "default" {}

resource "alicloud_vpc" "vpc" {
  vpc_name   = local.new_vpc_name
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vswitch_name = local.new_vsw_name
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = cidrsubnet(alicloud_vpc.vpc.cidr_block, 8, 8)
  zone_id      = data.alicloud_eci_zones.default.zones.0.zone_ids.1
}

resource "alicloud_security_group" "group" {
  name   = local.new_sg_name
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_cs_serverless_kubernetes" "serverless" {
  name                           = local.k8s_name_ask
  version                        = var.ack_version # 替换为您所需创建的集群版本。
  cluster_spec                   = var.cluster_spec
  vpc_id                         = alicloud_vpc.vpc.id
  vswitch_ids                    = split(",", join(",", alicloud_vswitch.vsw.*.id))
  new_nat_gateway                = true
  endpoint_public_access_enabled = true
  deletion_protection            = false
  security_group_id              = alicloud_security_group.group.id
  # 通过RRSA配置ServiceAccount。
  enable_rrsa             = true
  time_zone               = "Asia/Shanghai"
  service_cidr            = "10.13.0.0/16"
  service_discovery_types = ["CoreDNS"]

  # tags
  tags = {
    "cluster" = "ack-serverless"
  }
  # addons
  addons {
    name = "nginx-ingress-controller"
    # 使用Internet。
    config = "{\"IngressSlbNetworkType\":\"internet\",\"IngressSlbSpec\":\"slb.s2.small\"}"
    # 如果使用Intranet, 配置如下。
    # config = "{\"IngressSlbNetworkType\":\"intranet\",\"IngressSlbSpec\":\"slb.s2.small\"}"
  }
  addons {
    name = "metrics-server"
  }
  addons {
    name = "knative"
  }
  addons {
    name = "managed-arms-prometheus"
  }
  addons {
    name = "logtail-ds"
    # 指定具体的sls_project_name
    # config = "{\"sls_project_name\":\"<YOUR-SLS-PROJECT-NAME>}\"}"
  }
}