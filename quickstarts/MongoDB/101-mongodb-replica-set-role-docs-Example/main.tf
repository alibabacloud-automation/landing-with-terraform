variable "name" {
  default = "tf-example"
}

data "alicloud_mongodb_zones" "default" {}

locals {
  index   = length(data.alicloud_mongodb_zones.default.zones) - 1
  zone_id = data.alicloud_mongodb_zones.default.zones[local.index].id
}

resource "alicloud_vpc" "default" {
  cidr_block = "10.0.0.0/8"
  vpc_name   = var.name
}

resource "alicloud_vswitch" "default" {
  vpc_id     = alicloud_vpc.default.id
  zone_id    = local.zone_id
  cidr_block = "10.0.0.0/24"
}

resource "alicloud_mongodb_instance" "default" {
  engine_version      = "4.4"
  storage_type        = "cloud_essd1"
  vswitch_id          = alicloud_vswitch.default.id
  db_instance_storage = "20"
  vpc_id              = alicloud_vpc.default.id
  db_instance_class   = "mdb.shard.4x.large.d"
  storage_engine      = "WiredTiger"
  network_type        = "VPC"
  zone_id             = local.zone_id
}

resource "alicloud_mongodb_public_network_address" "default" {
  db_instance_id = alicloud_mongodb_instance.default.id
}

# modify private network address.
resource "alicloud_mongodb_replica_set_role" "private" {
  db_instance_id    = alicloud_mongodb_instance.default.id
  role_id           = alicloud_mongodb_instance.default.replica_sets[0].role_id
  connection_prefix = "test-tf-private-change"
  connection_port   = 3718
  network_type      = "VPC"
}

# modify public network address.
resource "alicloud_mongodb_replica_set_role" "public" {
  db_instance_id    = alicloud_mongodb_instance.default.id
  role_id           = alicloud_mongodb_public_network_address.default.replica_sets[0].role_id
  connection_prefix = "test-tf-public-0"
  connection_port   = 3719
  network_type      = "Public"
}