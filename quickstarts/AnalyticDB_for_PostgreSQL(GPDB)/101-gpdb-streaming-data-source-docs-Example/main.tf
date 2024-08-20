variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

variable "kafka-config-modify" {
  default = <<EOF
{
    "brokers": "alikafka-post-cn-g4t3t4eod004-1-vpc.alikafka.aliyuncs.com:9092,alikafka-post-cn-g4t3t4eod004-2-vpc.alikafka.aliyuncs.com:9092,alikafka-post-cn-g4t3t4eod004-3-vpc.alikafka.aliyuncs.com:9092",
    "delimiter": "#",
    "format": "delimited",
    "topic": "ziyuan_example"
}
EOF
}

variable "kafka-config" {
  default = <<EOF
{
    "brokers": "alikafka-post-cn-g4t3t4eod004-1-vpc.alikafka.aliyuncs.com:9092,alikafka-post-cn-g4t3t4eod004-2-vpc.alikafka.aliyuncs.com:9092,alikafka-post-cn-g4t3t4eod004-3-vpc.alikafka.aliyuncs.com:9092",
    "delimiter": "|",
    "format": "delimited",
    "topic": "ziyuan_example"
}
EOF
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "defaultDfkYOR" {
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "default59ZqyD" {
  vpc_id     = alicloud_vpc.defaultDfkYOR.id
  zone_id    = "cn-beijing-h"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_gpdb_instance" "default7mX6ld" {
  instance_spec         = "2C8G"
  description           = var.name
  seg_node_num          = "2"
  seg_storage_type      = "cloud_essd"
  instance_network_type = "VPC"
  db_instance_category  = "Basic"
  payment_type          = "PayAsYouGo"
  ssl_enabled           = "0"
  engine_version        = "6.0"
  zone_id               = "cn-beijing-h"
  vswitch_id            = alicloud_vswitch.default59ZqyD.id
  storage_size          = "50"
  master_cu             = "4"
  vpc_id                = alicloud_vpc.defaultDfkYOR.id
  db_instance_mode      = "StorageElastic"
  engine                = "gpdb"
}

resource "alicloud_gpdb_streaming_data_service" "defaultwruvdv" {
  service_name        = "example"
  db_instance_id      = alicloud_gpdb_instance.default7mX6ld.id
  service_description = "example"
  service_spec        = "8"
}


resource "alicloud_gpdb_streaming_data_source" "default" {
  db_instance_id          = alicloud_gpdb_instance.default7mX6ld.id
  data_source_name        = "example-kafka3"
  data_source_config      = var.kafka-config
  data_source_type        = "kafka"
  data_source_description = "example-kafka"
  service_id              = alicloud_gpdb_streaming_data_service.defaultwruvdv.service_id
}