terraform {
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
    }
  }
}

variable "name" {
  default = "terraform-example"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = cidrsubnet(alicloud_vpc.default.cidr_block, 8, 8)
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = var.name
}

resource "alicloud_cs_managed_kubernetes" "default" {
  name                         = var.name
  cluster_spec                 = "ack.pro.small"
  vswitch_ids                  = [alicloud_vswitch.default.id]
  pod_vswitch_ids              = [alicloud_vswitch.default.id]
  new_nat_gateway              = false
  is_enterprise_security_group = true
  slb_internet_enabled         = false
  deletion_protection          = false
}

resource "alicloud_cs_auto_repair_policy" "default" {
  cluster_id        = alicloud_cs_managed_kubernetes.default.id
  name              = var.name
  resource_sub_type = "ess"

  rules {
    incidents {
      name = "NTPProblem"
    }
    repair_procedure {
      name = "QuarantineNode"
    }
    repair_procedure {
      name   = "Evict"
      config = jsonencode({ evict_timeout = 300 })
    }
    repair_procedure {
      name = "Repair"

      intervention {
        enable = true
        type   = "label"
        inquiring_label {
          key   = "intervention.autorepair.node.k8s.aliyun.com/repair"
          value = "inquiring"
        }
        approved_label {
          key   = "intervention.autorepair.node.k8s.aliyun.com/repair"
          value = "approved"
        }
      }
    }
    repair_procedure {
      name = "UnquarantineNode"
    }
  }
}