variable "name" {
  default = "terraform-example"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_alikafka_instance" "default" {
  name            = var.name
  partition_num   = 50
  disk_type       = "1"
  disk_size       = "500"
  deploy_type     = "5"
  io_max          = "20"
  spec_type       = "professional"
  service_version = "2.2.0"
  vswitch_id      = alicloud_vswitch.default.id
  security_group  = alicloud_security_group.default.id
  config = jsonencode(
    {
      "enable.acl" : "true"
    }
  )
}

resource "alicloud_alikafka_topic" "default" {
  instance_id   = alicloud_alikafka_instance.default.id
  topic         = var.name
  remark        = var.name
  local_topic   = "true"
  compact_topic = "true"
  partition_num = "18"
  configs = jsonencode(
    {
      "message.format.version" : "2.2.0",
      "max.message.bytes" : "10485760",
      "min.insync.replicas" : "1",
      "replication-factor" : "2",
      "retention.ms" : "3600000"
    }
  )
  tags = {
    Created = "TF",
    For     = "example",
  }
}