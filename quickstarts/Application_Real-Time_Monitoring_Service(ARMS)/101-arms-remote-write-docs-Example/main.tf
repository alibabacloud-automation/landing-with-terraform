variable "name" {
  default = "tf-example"
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
  zone_id      = data.alicloud_zones.default.zones[length(data.alicloud_zones.default.zones) - 1].id
}

resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = alicloud_vpc.default.id
}

data "alicloud_resource_manager_resource_groups" "default" {
}

resource "alicloud_arms_prometheus" "default" {
  cluster_type        = "ecs"
  grafana_instance_id = "free"
  vpc_id              = alicloud_vpc.default.id
  vswitch_id          = alicloud_vswitch.default.id
  security_group_id   = alicloud_security_group.default.id
  cluster_name        = "${var.name}-${alicloud_vpc.default.id}"
  resource_group_id   = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  tags = {
    Created = "TF"
    For     = "Prometheus"
  }
}

resource "alicloud_arms_remote_write" "default" {
  cluster_id        = alicloud_arms_prometheus.default.id
  remote_write_yaml = "remote_write:\n- name: ArmsRemoteWrite\n  url: http://47.96.227.137:8080/prometheus/xxx/yyy/cn-hangzhou/api/v3/write\n  basic_auth: {username: 666, password: '******'}\n  write_relabel_configs:\n  - source_labels: [instance_id]\n    separator: ;\n    regex: si-6e2ca86444db4e55a7c1\n    replacement: $1\n    action: keep\n"
}