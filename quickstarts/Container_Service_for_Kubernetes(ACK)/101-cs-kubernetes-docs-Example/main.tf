variable "name" {
  default = "tf-example"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}
data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

data "alicloud_instance_types" "default" {
  count                = 3
  availability_zone    = data.alicloud_zones.default.zones[count.index].id
  cpu_core_count       = 4
  memory_size          = 8
  kubernetes_node_role = "Master"
  system_disk_category = "cloud_essd"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}
resource "alicloud_vswitch" "default" {
  count        = 3
  vswitch_name = format("${var.name}_%d", count.index + 1)
  cidr_block   = format("10.4.%d.0/24", count.index + 1)
  zone_id      = data.alicloud_zones.default.zones[count.index].id
  vpc_id       = alicloud_vpc.default.id
}

resource "alicloud_cs_kubernetes" "default" {
  master_vswitch_ids    = alicloud_vswitch.default.*.id
  master_instance_types = [data.alicloud_instance_types.default.0.instance_types.0.id, data.alicloud_instance_types.default.1.instance_types.0.id, data.alicloud_instance_types.default.2.instance_types.0.id]
  master_disk_category  = "cloud_essd"
  version               = "1.24.6-aliyun.1"
  password              = "Yourpassword1234"
  pod_cidr              = "10.72.0.0/16"
  service_cidr          = "172.18.0.0/16"
  load_balancer_spec    = "slb.s2.small"
  install_cloud_monitor = "true"
  resource_group_id     = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  deletion_protection   = "false"
  timezone              = "Asia/Shanghai"
  os_type               = "Linux"
  platform              = "CentOS"
  cluster_domain        = "cluster.local"
  proxy_mode            = "ipvs"
  custom_san            = "www.terraform.io"
  new_nat_gateway       = "true"
}