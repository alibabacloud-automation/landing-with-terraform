variable "name" {
  default = "tf-example"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}
data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones.0.id
  cpu_core_count       = 4
  memory_size          = 8
  kubernetes_node_role = "Master"
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

resource "alicloud_cs_edge_kubernetes" "default" {
  name_prefix                  = var.name
  worker_vswitch_ids           = [alicloud_vswitch.default.id]
  worker_instance_types        = [data.alicloud_instance_types.default.instance_types.0.id]
  version                      = "1.26.3-aliyun.1"
  worker_number                = "1"
  password                     = "Test12345"
  pod_cidr                     = "10.99.0.0/16"
  service_cidr                 = "172.16.0.0/16"
  worker_instance_charge_type  = "PostPaid"
  new_nat_gateway              = "true"
  node_cidr_mask               = "24"
  install_cloud_monitor        = "true"
  slb_internet_enabled         = "true"
  is_enterprise_security_group = "true"
  worker_data_disks {
    category  = "cloud_ssd"
    size      = "200"
    encrypted = "false"
  }
}