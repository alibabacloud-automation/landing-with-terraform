variable "vpc_cidr" {
  default = "10.0.0.0/8"
}

variable "vswitch_cidrs" {
  type    = list(string)
  default = ["10.1.0.0/16", "10.2.0.0/16"]
}

variable "cluster_name" {
  default = "terraform-example-"
}

variable "pod_cidr" {
  default = "172.16.0.0/16"
}

variable "service_cidr" {
  default = "192.168.0.0/16"
}

data "alicloud_enhanced_nat_available_zones" "enhanced" {}

resource "alicloud_vpc" "CreateVPC" {
  cidr_block = var.vpc_cidr
}

# According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "CreateVSwitch" {
  count      = length(var.vswitch_cidrs)
  vpc_id     = alicloud_vpc.CreateVPC.id
  cidr_block = element(var.vswitch_cidrs, count.index)
  zone_id    = data.alicloud_enhanced_nat_available_zones.enhanced.zones[count.index].zone_id
}

resource "alicloud_cs_managed_kubernetes" "CreateCluster" {
  name_prefix                  = var.cluster_name
  cluster_spec                 = "ack.standard"
  profile                      = "Default"
  vswitch_ids                  = split(",", join(",", alicloud_vswitch.CreateVSwitch.*.id))
  pod_cidr                     = var.pod_cidr
  service_cidr                 = var.service_cidr
  is_enterprise_security_group = true
  ip_stack                     = "ipv4"
  proxy_mode                   = "ipvs"
  deletion_protection          = false

  addons {
    name = "gatekeeper"
  }
  addons {
    name = "loongcollector"
  }
  addons {
    name = "policy-template-controller"
  }

  operation_policy {
    cluster_auto_upgrade {
      enabled = false
    }
  }
  maintenance_window {
    enable = false
  }
}

resource "alicloud_cs_kubernetes_policy_instance" "base" {
  cluster_id  = alicloud_cs_managed_kubernetes.CreateCluster.id
  policy_name = "ACKPSPReadOnlyRootFilesystem"
}

resource "alicloud_cs_kubernetes_policy_instance" "string" {
  cluster_id  = alicloud_cs_managed_kubernetes.CreateCluster.id
  policy_name = "ACKPVSizeConstraint"
  action      = "deny"
  parameters = {
    maxSize = "60Gi"
  }
}

resource "alicloud_cs_kubernetes_policy_instance" "int_bool" {
  cluster_id  = alicloud_cs_managed_kubernetes.CreateCluster.id
  policy_name = "ACKPSPHostNetworkingPorts"
  namespaces = [
    "test"
  ]
  parameters = {
    hostNetwork = true
    min         = 20
    max         = 200
  }
}

resource "alicloud_cs_kubernetes_policy_instance" "array" {
  cluster_id  = alicloud_cs_managed_kubernetes.CreateCluster.id
  policy_name = "ACKAllowedRepos"
  parameters = {
    repos = jsonencode([
      "docker.io/library/nginx",
      "docker.io/library/redis"
    ])
  }
}

resource "alicloud_cs_kubernetes_policy_instance" "object" {
  cluster_id  = alicloud_cs_managed_kubernetes.CreateCluster.id
  policy_name = "ACKRequiredLabels"
  action      = "warn"
  namespaces = [
    "test1",
    "test2",
    "test3"
  ]
  parameters = {
    labels = jsonencode([
      {
        key          = "test"
        allowedRegex = "^test.*$"
      },
      {
        key          = "env"
        allowedRegex = "^(dev|prod)$"
        optional     = false
      }
    ])
  }
}