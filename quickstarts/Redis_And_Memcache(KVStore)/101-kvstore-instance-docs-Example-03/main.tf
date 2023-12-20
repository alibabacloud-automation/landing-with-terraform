variable "name" {
  default = "tf-example-with-connection"
}
data "alicloud_kvstore_zones" "default" {
  product_type = "OnECS"
}
data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_kvstore_zones.default.zones.0.id
}

resource "alicloud_kvstore_instance" "default" {
  db_instance_name          = var.name
  vswitch_id                = alicloud_vswitch.default.id
  resource_group_id         = data.alicloud_resource_manager_resource_groups.default.ids.0
  zone_id                   = data.alicloud_kvstore_zones.default.zones.0.id
  secondary_zone_id         = data.alicloud_kvstore_zones.default.zones.1.id
  instance_class            = "redis.shard.small.ce"
  instance_type             = "Redis"
  engine_version            = "7.0"
  maintain_start_time       = "04:00Z"
  maintain_end_time         = "06:00Z"
  backup_period             = ["Wednesday"]
  backup_time               = "11:00Z-12:00Z"
  private_connection_prefix = "exampleconnectionprefix"
  private_connection_port   = 4011
  security_ips              = ["10.23.12.24"]
  config = {
    appendonly             = "yes"
    lazyfree-lazy-eviction = "yes"
    EvictionPolicy         = "volatile-lru"
  }
  tags = {
    Created = "TF",
    For     = "example",
  }
}