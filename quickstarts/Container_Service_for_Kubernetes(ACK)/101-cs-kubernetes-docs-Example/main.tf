variable "name" {
  default = "tf-kubernetes-example"
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
  default     = ["10.1.0.0/16", "10.2.0.0/16", "10.3.0.0/16"]
}

variable "terway_vswitch_ids" {
  description = "List of existing vswitch ids for terway."
  type        = list(string)
  default     = []
}

variable "terway_vswitch_cidrs" {
  description = "List of cidr blocks used to create several new vswitches when 'terway_vswitch_cidrs' is not specified."
  type        = list(string)
  default     = ["10.4.0.0/16", "10.5.0.0/16", "10.6.0.0/16"]
}

variable "cluster_addons" {
  type = list(object({
    name   = string
    config = map(string)
  }))

  default = [
    # If use terway network, must specify addons with `terway-eniip` and param `pod_vswitch_ids`
    {
      "name"   = "terway-eniip",
      "config" = {},
    },
    {
      "name"   = "csi-plugin",
      "config" = {},
    },
    {
      "name"   = "csi-provisioner",
      "config" = {},
    },
    {
      "name" = "logtail-ds",
      "config" = {
        "IngressDashboardEnabled" = "true",
      }
    },
    {
      "name" = "nginx-ingress-controller",
      "config" = {
        "IngressSlbNetworkType" = "internet"
      }
    },
    {
      "name"   = "arms-prometheus",
      "config" = {},
    },
    {
      "name" = "ack-node-problem-detector",
      "config" = {
        "sls_project_name" = ""
      },
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
  zone_id    = data.alicloud_enhanced_nat_available_zones.enhanced.zones[count.index < length(data.alicloud_enhanced_nat_available_zones.enhanced.zones) ? count.index : 0].zone_id
}

# According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "terway_vswitches" {
  count      = length(var.terway_vswitch_ids) > 0 ? 0 : length(var.terway_vswitch_cidrs)
  vpc_id     = var.vpc_id == "" ? join("", alicloud_vpc.vpc.*.id) : var.vpc_id
  cidr_block = element(var.terway_vswitch_cidrs, count.index)
  zone_id    = data.alicloud_enhanced_nat_available_zones.enhanced.zones[count.index < length(data.alicloud_enhanced_nat_available_zones.enhanced.zones) ? count.index : 0].zone_id
}

data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

data "alicloud_instance_types" "cloud_essd" {
  count                = 3
  availability_zone    = data.alicloud_enhanced_nat_available_zones.enhanced.zones[count.index < length(data.alicloud_enhanced_nat_available_zones.enhanced.zones) ? count.index : 0].zone_id
  cpu_core_count       = 4
  memory_size          = 8
  system_disk_category = "cloud_essd"
}

resource "alicloud_cs_kubernetes" "default" {
  master_vswitch_ids    = length(var.vswitch_ids) > 0 ? split(",", join(",", var.vswitch_ids)) : length(var.vswitch_cidrs) < 1 ? [] : split(",", join(",", alicloud_vswitch.vswitches.*.id))
  pod_vswitch_ids       = length(var.terway_vswitch_ids) > 0 ? split(",", join(",", var.terway_vswitch_ids)) : length(var.terway_vswitch_cidrs) < 1 ? [] : split(",", join(",", alicloud_vswitch.terway_vswitches.*.id))
  master_instance_types = [data.alicloud_instance_types.cloud_essd.0.instance_types.0.id, data.alicloud_instance_types.cloud_essd.1.instance_types.0.id, data.alicloud_instance_types.cloud_essd.2.instance_types.0.id]
  master_disk_category  = "cloud_essd"
  password              = "Yourpassword1234"
  service_cidr          = "172.18.0.0/16"
  load_balancer_spec    = "slb.s1.small"
  install_cloud_monitor = "true"
  resource_group_id     = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  deletion_protection   = "false"
  timezone              = "Asia/Shanghai"
  os_type               = "Linux"
  platform              = "AliyunLinux3"
  cluster_domain        = "cluster.local"
  proxy_mode            = "ipvs"
  custom_san            = "www.terraform.io"
  new_nat_gateway       = "true"
  dynamic "addons" {
    for_each = var.cluster_addons
    content {
      name   = lookup(addons.value, "name", var.cluster_addons)
      config = jsonencode(lookup(addons.value, "config", var.cluster_addons))
    }
  }
}