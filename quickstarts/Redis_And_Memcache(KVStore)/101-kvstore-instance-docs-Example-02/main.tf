variable "name" {
  default = "tf-example-prepaid"
}
data "alicloud_kvstore_zones" "default" {
  instance_charge_type = "PrePaid"
}
data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

// PrePaid instance can not deleted and there suggests using an existing vpc and vswitch, like default vpc.
data "alicloud_vpcs" "default" {
  is_default = true
}
data "alicloud_vswitches" "default" {
  zone_id = data.alicloud_kvstore_zones.default.zones.0.id
  vpc_id  = data.alicloud_vpcs.default.ids.0
}

resource "alicloud_kvstore_instance" "default" {
  db_instance_name  = var.name
  vswitch_id        = data.alicloud_vswitches.default.ids.0
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.0
  zone_id           = data.alicloud_kvstore_zones.default.zones.0.id
  secondary_zone_id = data.alicloud_kvstore_zones.default.zones.1.id
  instance_class    = "redis.master.large.default"
  instance_type     = "Redis"
  engine_version    = "5.0"
  payment_type      = "PrePaid"
  period            = "12"
  security_ips      = ["10.23.12.24"]
  config = {
    appendonly             = "no"
    lazyfree-lazy-eviction = "no"
    EvictionPolicy         = "volatile-lru"
  }
  tags = {
    Created = "TF",
    For     = "example",
  }
}