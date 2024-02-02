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
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_cs_managed_kubernetes" "default" {
  name_prefix          = var.name
  cluster_spec         = "ack.pro.small"
  worker_vswitch_ids   = [alicloud_vswitch.default.id]
  new_nat_gateway      = false
  pod_cidr             = cidrsubnet("10.0.0.0/8", 8, 36)
  service_cidr         = cidrsubnet("172.16.0.0/16", 4, 7)
  slb_internet_enabled = true
  # By defining the addons attribute in cluster resource, it indicates that the addon will be installed when creating a cluster
  addons {
    name = "logtail-ds"
    # Specify the addon config. Or it can be written as
    # config = "{\"IngressDashboardEnabled\":\"true\"}
    config = jsonencode(
      {
        IngressDashboardEnabled = true
      }
    )
    # The default value of this parameter is false.Some addon will be installed by default to facilitate users to manage the cluster. If you do not need to install these addons when creating a cluster, you can set disabled=true.
    disabled = false
  }
}
# data source provides the information of available addons
data "alicloud_cs_kubernetes_addons" "default" {
  cluster_id = alicloud_cs_managed_kubernetes.default.id
  name_regex = "logtail-ds"
}
# Manage addon resource
resource "alicloud_cs_kubernetes_addon" "logtail-ds" {
  cluster_id = alicloud_cs_managed_kubernetes.default.id
  name       = "logtail-ds"
  # Manage addon version
  version = "v1.6.0.0-aliyun"
  # Manage addon config
  config = jsonencode(
    {}
  )
}