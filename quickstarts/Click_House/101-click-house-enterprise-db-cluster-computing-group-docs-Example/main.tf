variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

variable "vsw__ip_range_i" {
  default = "172.16.1.0/24"
}

variable "region_id" {
  default = "cn-beijing"
}

variable "vpc__ip_range" {
  default = "172.16.0.0/12"
}

variable "vsw__ip_range_k" {
  default = "172.16.3.0/24"
}

variable "vsw__ip_range_l" {
  default = "172.16.2.0/24"
}

variable "zone_id_i" {
  default = "cn-beijing-i"
}

variable "zone_id_l" {
  default = "cn-beijing-l"
}

variable "zone_id_k" {
  default = "cn-beijing-k"
}

resource "alicloud_vpc" "defaultp2mwWM" {
  cidr_block = var.vpc__ip_range
}

resource "alicloud_vswitch" "defaultkCZhNu" {
  vpc_id     = alicloud_vpc.defaultp2mwWM.id
  zone_id    = var.zone_id_i
  cidr_block = var.vsw__ip_range_i
}

resource "alicloud_click_house_enterprise_db_cluster" "defaultQ5vukB" {
  zone_id        = alicloud_vswitch.defaultkCZhNu.zone_id
  vpc_id         = alicloud_vpc.defaultp2mwWM.id
  node_scale_min = "4"
  node_scale_max = "4"
  node_count     = "2"
  vswitch_id     = alicloud_vswitch.defaultkCZhNu.id
}


resource "alicloud_click_house_enterprise_db_cluster_computing_group" "default" {
  node_scale_min              = "4"
  computing_group_description = "example"
  node_count                  = "2"
  db_instance_id              = alicloud_click_house_enterprise_db_cluster.defaultQ5vukB.id
  node_scale_max              = "4"
  is_readonly                 = false
}