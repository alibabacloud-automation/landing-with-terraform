variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

variable "zone_id" {
  default = "cn-shanghai-f"
}

variable "region_id" {
  default = "cn-shanghai"
}

resource "alicloud_vpc" "defaultX7MgJO" {
  description = var.name
  cidr_block  = "10.0.0.0/8"
  vpc_name    = "amp-example-shanghai"
}

resource "alicloud_vswitch" "default45mCzM" {
  description = var.name
  vpc_id      = alicloud_vpc.defaultX7MgJO.id
  zone_id     = var.zone_id
  cidr_block  = "10.0.0.0/24"
}

resource "alicloud_lindorm_instance" "defaultQpsLKr" {
  payment_type               = "PayAsYouGo"
  table_engine_node_count    = "2"
  instance_storage           = "80"
  zone_id                    = var.zone_id
  vswitch_id                 = alicloud_vswitch.default45mCzM.id
  disk_category              = "cloud_efficiency"
  table_engine_specification = "lindorm.g.xlarge"
  instance_name              = "tf-example"
  vpc_id                     = alicloud_vpc.defaultX7MgJO.id
}


resource "alicloud_lindorm_public_network" "default" {
  instance_id           = alicloud_lindorm_instance.defaultQpsLKr.id
  enable_public_network = "1"
  engine_type           = "lindorm"
}