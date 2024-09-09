variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

data "alicloud_express_connect_physical_connections" "default" {
  name_regex = "preserved-NODELETING"
}

resource "alicloud_express_connect_traffic_qos" "createQos" {
  qos_name        = var.name
  qos_description = "terraform-example"
}

resource "alicloud_express_connect_traffic_qos_association" "associateQos" {
  instance_id   = data.alicloud_express_connect_physical_connections.default.ids.1
  qos_id        = alicloud_express_connect_traffic_qos.createQos.id
  instance_type = "PHYSICALCONNECTION"
}

resource "alicloud_express_connect_traffic_qos_queue" "createQosQueue" {
  qos_id            = alicloud_express_connect_traffic_qos.createQos.id
  bandwidth_percent = "60"
  queue_description = "terraform-example"
  queue_name        = var.name
  queue_type        = "Medium"
}


resource "alicloud_express_connect_traffic_qos_rule" "default" {
  rule_description = "terraform-example"
  priority         = "1"
  protocol         = "ALL"
  src_port_range   = "-1/-1"
  dst_ipv6_cidr    = "2001:db8:1234:5678::/64"
  src_ipv6_cidr    = "2001:db8:1234:5678::/64"
  dst_port_range   = "-1/-1"
  remarking_dscp   = "-1"
  queue_id         = alicloud_express_connect_traffic_qos_queue.createQosQueue.queue_id
  qos_id           = alicloud_express_connect_traffic_qos.createQos.id
  match_dscp       = "-1"
  rule_name        = var.name
}