variable "region" {
  default = "cn-shanghai"
}

variable "vpc_cidr_block" {
  default = "172.16.0.0/22"
}

variable "vsw_cidr_block" {
  default = "172.16.0.0/24"
}

variable "service_cidr" {
  default = "192.16.0.0/19"
}

variable "kubernetes_version" {
  # 替换为您所需创建的集群版本。
  default = "1.32.1-aliyun.1"
}

variable "cluster_spec" {
  # 替换为您所需创建的集群规格。
  default = "ack.pro.small"
}

provider "alicloud" {
  region = var.region
}


locals {
  # 服务网格的规格，可以选择三种规格：standard: 标准版（免费），enterprise：企业版，ultimate：旗舰版。
  mesh_spec = "enterprise"
  # 获取服务网格的最新版本
  mesh_versions       = split(":", data.alicloud_service_mesh_versions.default.ids[0])
  count               = length(local.mesh_versions)
  last_versionversion = local.mesh_versions[local.count - 1]
}

# 查询可以创建交换机的可用区
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

# 查询可以创建的服务网格版本。
data "alicloud_service_mesh_versions" "default" {
  edition = local.mesh_spec == "standard" ? "Default" : "Pro"
}

# 随机数
resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 专有网络VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc-test_${random_integer.default.result}"
  cidr_block = var.vpc_cidr_block
}

# 交换机
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vsw_cidr_block
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "vswitch-test-${random_integer.default.result}"
}

# 创建ACK Serverless集群
resource "alicloud_cs_serverless_kubernetes" "serverless" {
  name                           = "ack-tf-test-${random_integer.default.result}"
  version                        = var.kubernetes_version
  cluster_spec                   = var.cluster_spec
  vpc_id                         = alicloud_vpc.vpc.id
  vswitch_ids                    = split(",", join(",", alicloud_vswitch.vswitch.*.id))
  new_nat_gateway                = true
  endpoint_public_access_enabled = true
  deletion_protection            = false
  enable_rrsa                    = true
  time_zone                      = "Asia/Shanghai"
  service_cidr                   = "10.13.0.0/16"
  service_discovery_types        = ["CoreDNS"]
  tags = {
    "cluster" = "ack-serverless"
  }
  addons {
    name   = "nginx-ingress-controller"
    config = "{\"IngressSlbNetworkType\":\"internet\",\"IngressSlbSpec\":\"slb.s2.small\"}"
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
  }
}

# 服务网格资源
resource "alicloud_service_mesh_service_mesh" "default" {
  service_mesh_name = "vsw-tf-${random_integer.default.result}"
  version           = local.last_versionversion
  cluster_spec      = local.mesh_spec
  edition           = "Default"
  # 添加集群
  # cluster_ids = [alicloud_cs_serverless_kubernetes.serverless.id]
  network {
    vpc_id        = alicloud_vpc.vpc.id
    vswitche_list = [alicloud_vswitch.vswitch.id]
  }
  load_balancer {
    api_server_public_eip = true
    pilot_public_eip      = false
  }
  mesh_config {
    enable_locality_lb = false
    access_log {
      enabled = true
    }
    control_plane_log {
      enabled = true
    }
    tracing = true
    pilot {
      trace_sampling = 100
      http10_enabled = true
    }
    telemetry = true
    kiali {
      enabled = true
    }

    audit {
      enabled = true
    }
  }
  lifecycle {
    ignore_changes = [edition, mesh_config]
  }
}