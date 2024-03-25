variable "name" {
  default = "tf-example"
}

# leave it to empty would create a new one
variable "vpc_id" {
  description = "Existing vpc id used to create several vswitches and other resources."
  default     = ""
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc when 'vpc_id' is not specified."
  default     = "10.0.0.0/8"
}

# leave it to empty then terraform will create several vswitches
variable "vswitch_ids" {
  description = "List of existing vswitch id."
  type        = list(string)
  default     = []
}


variable "vswitch_cidrs" {
  description = "List of cidr blocks used to create several new vswitches when 'vswitch_ids' is not specified."
  type        = list(string)
  default     = ["10.1.0.0/16", "10.2.0.0/16"]
}

# options: between 24-28
variable "node_cidr_mask" {
  description = "The node cidr block to specific how many pods can run on single node."
  default     = 24
}

# options: ipvs|iptables
variable "proxy_mode" {
  description = "Proxy mode is option of kube-proxy."
  default     = "ipvs"
}

variable "service_cidr" {
  description = "The kubernetes service cidr block. It cannot be equals to vpc's or vswitch's or pod's and cannot be in them."
  default     = "192.168.0.0/16"
}

variable "terway_vswitch_ids" {
  description = "List of existing vswitch ids for terway."
  type        = list(string)
  default     = []
}

variable "terway_vswitch_cidrs" {
  description = "List of cidr blocks used to create several new vswitches when 'terway_vswitch_cidrs' is not specified."
  type        = list(string)
  default     = ["10.4.0.0/16", "10.5.0.0/16"]
}

variable "cluster_addons" {
  type = list(object({
    name   = string
    config = string
  }))

  default = [
    {
      "name"   = "terway-eniip",
      "config" = "",
    },
    {
      "name"   = "csi-plugin",
      "config" = "",
    },
    {
      "name"   = "csi-provisioner",
      "config" = "",
    },
    {
      "name"   = "logtail-ds",
      "config" = "{'IngressDashboardEnabled':'true'}",
    },
    {
      "name"   = "nginx-ingress-controller",
      "config" = "{'IngressSlbNetworkType':'internet'}",
    },
    {
      "name"   = "arms-prometheus",
      "config" = "",
    },
    {
      "name"   = "ack-node-problem-detector",
      "config" = "{'sls_project_name':''}",
    }
  ]
}

data "alicloud_enhanced_nat_available_zones" "enhanced" {}

# If there is not specifying vpc_id, the module will launch a new vpc
resource "alicloud_vpc" "vpc" {
  count      = var.vpc_id == "" ? 1 : 0
  cidr_block = var.vpc_cidr
}

# According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "vswitches" {
  count      = length(var.vswitch_ids) > 0 ? 0 : length(var.vswitch_cidrs)
  vpc_id     = var.vpc_id == "" ? join("", alicloud_vpc.vpc.*.id) : var.vpc_id
  cidr_block = element(var.vswitch_cidrs, count.index)
  zone_id    = data.alicloud_enhanced_nat_available_zones.enhanced.zones[count.index].zone_id
}

# According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "terway_vswitches" {
  count      = length(var.terway_vswitch_ids) > 0 ? 0 : length(var.terway_vswitch_cidrs)
  vpc_id     = var.vpc_id == "" ? join("", alicloud_vpc.vpc.*.id) : var.vpc_id
  cidr_block = element(var.terway_vswitch_cidrs, count.index)
  zone_id    = data.alicloud_enhanced_nat_available_zones.enhanced.zones[count.index].zone_id
}

resource "alicloud_cs_managed_kubernetes" "k8s" {
  name_prefix  = var.name
  cluster_spec = "ack.pro.small"
  # version can not be defined in variables.tf.
  version            = "1.26.3-aliyun.1"
  worker_vswitch_ids = length(var.vswitch_ids) > 0 ? split(",", join(",", var.vswitch_ids)) : length(var.vswitch_cidrs) < 1 ? [] : split(",", join(",", alicloud_vswitch.vswitches.*.id))
  pod_vswitch_ids    = length(var.terway_vswitch_ids) > 0 ? split(",", join(",", var.terway_vswitch_ids)) : length(var.terway_vswitch_cidrs) < 1 ? [] : split(",", join(",", alicloud_vswitch.terway_vswitches.*.id))
  new_nat_gateway    = true
  node_cidr_mask     = var.node_cidr_mask
  proxy_mode         = var.proxy_mode
  service_cidr       = var.service_cidr

  dynamic "addons" {
    for_each = var.cluster_addons
    content {
      name   = lookup(addons.value, "name", var.cluster_addons)
      config = lookup(addons.value, "config", var.cluster_addons)
    }
  }
}