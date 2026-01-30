variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
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
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.4.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_alikafka_instance" "default" {
  deploy_type     = "4"
  instance_type   = "alikafka_serverless"
  vswitch_id      = alicloud_vswitch.default.id
  spec_type       = "normal"
  service_version = "3.3.1"
  security_group  = alicloud_security_group.default.id
  config          = "{\"enable.acl\":\"true\"}"
  serverless_config {
    reserved_publish_capacity   = 60
    reserved_subscribe_capacity = 60
  }
}

resource "alicloud_alikafka_scheduled_scaling_rule" "default" {
  schedule_type        = "repeat"
  reserved_sub_flow    = "200"
  reserved_pub_flow    = "200"
  time_zone            = "GMT+8"
  duration_minutes     = "100"
  first_scheduled_time = "1769578000000"
  enable               = false
  repeat_type          = "Weekly"
  weekly_types         = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
  rule_name            = var.name
  instance_id          = alicloud_alikafka_instance.default.id
}