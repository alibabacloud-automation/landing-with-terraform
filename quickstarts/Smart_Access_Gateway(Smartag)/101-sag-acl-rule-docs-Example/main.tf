variable "name" {
  default = "tf_example"
}
provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_sag_acl" "default" {
  name = var.name
}

resource "alicloud_sag_acl_rule" "default" {
  acl_id            = alicloud_sag_acl.default.id
  description       = var.name
  policy            = "accept"
  ip_protocol       = "ALL"
  direction         = "in"
  source_cidr       = "10.10.1.0/24"
  source_port_range = "-1/-1"
  dest_cidr         = "192.168.1.0/24"
  dest_port_range   = "-1/-1"
  priority          = "1"
}