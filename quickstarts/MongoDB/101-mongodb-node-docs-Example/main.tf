variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

variable "zone_id" {
  default = "cn-shanghai-b"
}

variable "region_id" {
  default = "cn-shanghai"
}

variable "ipv4_cidr" {
  default = "10.0.0.0/24"
}

resource "alicloud_vpc" "default" {
  description = "tf-example"
  vpc_name    = "tf-vpc-shanghai-b"
  cidr_block  = "10.0.0.0/8"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  zone_id      = var.zone_id
  cidr_block   = var.ipv4_cidr
  vswitch_name = "tf-shanghai-B"
}

resource "alicloud_mongodb_sharding_instance" "default" {
  engine_version   = "4.2"
  vswitch_id       = alicloud_vswitch.default.id
  zone_id          = var.zone_id
  name             = var.name
  storage_type     = "cloud_auto"
  provisioned_iops = 60
  config_server_list {
    node_class   = "mdb.shard.2x.xlarge.d"
    node_storage = 40
  }
  mongo_list {
    node_class = "mdb.shard.2x.xlarge.d"
  }
  mongo_list {
    node_class = "mdb.shard.2x.xlarge.d"
  }
  shard_list {
    node_class   = "mdb.shard.2x.xlarge.d"
    node_storage = 40
  }
  shard_list {
    node_class   = "mdb.shard.2x.xlarge.d"
    node_storage = 40
  }
  lifecycle {
    ignore_changes = [shard_list]
  }
}

resource "alicloud_mongodb_node" "default" {
  account_password  = "q1w2e3r4!"
  auto_pay          = "true"
  node_class        = "mdb.shard.4x.large.d"
  shard_direct      = "false"
  business_info     = "1234"
  node_storage      = "40"
  readonly_replicas = "0"
  db_instance_id    = alicloud_mongodb_sharding_instance.default.id
  node_type         = "shard"
  account_name      = "root"
}