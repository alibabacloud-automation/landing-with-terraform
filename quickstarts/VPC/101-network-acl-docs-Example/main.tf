variable "name" {
  default = "tf-example"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}
resource "alicloud_vpc" "example" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "example" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.example.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_network_acl" "example" {
  vpc_id           = alicloud_vpc.example.id
  network_acl_name = var.name
  description      = var.name
  ingress_acl_entries {
    description            = "${var.name}-ingress"
    network_acl_entry_name = "${var.name}-ingress"
    source_cidr_ip         = "10.0.0.0/24"
    policy                 = "accept"
    port                   = "20/80"
    protocol               = "tcp"
  }
  egress_acl_entries {
    description            = "${var.name}-egress"
    network_acl_entry_name = "${var.name}-egress"
    destination_cidr_ip    = "10.0.0.0/24"
    policy                 = "accept"
    port                   = "20/80"
    protocol               = "tcp"
  }
  resources {
    resource_id   = alicloud_vswitch.example.id
    resource_type = "VSwitch"
  }
}