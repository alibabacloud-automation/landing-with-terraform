variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "defaultTXqb15" {
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "defaultaSWhbT" {
  vpc_id     = alicloud_vpc.defaultTXqb15.id
  zone_id    = "cn-beijing-h"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_gpdb_instance" "defaulth2ghc1" {
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
  vswitch_id            = alicloud_vswitch.defaultaSWhbT.id
  storage_size          = "50"
  master_cu             = "4"
  vpc_id                = alicloud_vpc.defaultTXqb15.id
  db_instance_mode      = "StorageElastic"
  engine                = "gpdb"
}

resource "alicloud_gpdb_streaming_data_service" "default2dUszY" {
  service_name        = "example"
  db_instance_id      = alicloud_gpdb_instance.defaulth2ghc1.id
  service_description = "example"
  service_spec        = "8"
}

resource "alicloud_gpdb_streaming_data_source" "defaultcDQItu" {
  db_instance_id          = alicloud_gpdb_instance.defaulth2ghc1.id
  data_source_name        = "example"
  data_source_config      = jsonencode({ "brokers" : "alikafka-post-cn-g4t3t4eod004-1-vpc.alikafka.aliyuncs.com:9092,alikafka-post-cn-g4t3t4eod004-2-vpc.alikafka.aliyuncs.com:9092,alikafka-post-cn-g4t3t4eod004-3-vpc.alikafka.aliyuncs.com:9092", "delimiter" : "|", "format" : "delimited", "topic" : "ziyuan_example" })
  data_source_type        = "kafka"
  data_source_description = "example"
  service_id              = alicloud_gpdb_streaming_data_service.default2dUszY.service_id
}


resource "alicloud_gpdb_streaming_job" "default" {
  account         = "example_001"
  dest_schema     = "public"
  mode            = "professional"
  job_name        = "example-kafka"
  job_description = "example-kafka"
  dest_database   = "adb_sampledata_tpch"
  db_instance_id  = alicloud_gpdb_instance.defaulth2ghc1.id
  dest_table      = "customer"
  data_source_id  = alicloud_gpdb_streaming_data_source.defaultcDQItu.data_source_id
  password        = "example_001"
  job_config      = <<EOF
ATABASE: adb_sampledata_tpch
USER: example_001
PASSWORD: example_001
HOST: gp-2zean69451zsjj139-master.gpdb.rds.aliyuncs.com
PORT: 5432
KAFKA:
  INPUT:
    SOURCE:
      BROKERS: alikafka-post-cn-3mp3t4ekq004-1-vpc.alikafka.aliyuncs.com:9092
      TOPIC: ziyuan_example
      FALLBACK_OFFSET: LATEST
    KEY:
      COLUMNS:
      - NAME: c_custkey
        TYPE: int
      FORMAT: delimited
      DELIMITED_OPTION:
        DELIMITER: \'|\'
    VALUE:
      COLUMNS:
      - NAME: c_comment
        TYPE: varchar
      FORMAT: delimited
      DELIMITED_OPTION:
        DELIMITER: \'|\'
    ERROR_LIMIT: 10
  OUTPUT:
    SCHEMA: public
    TABLE: customer
    MODE: MERGE
    MATCH_COLUMNS:
    - c_custkey
    ORDER_COLUMNS:
    - c_custkey
    UPDATE_COLUMNS:
    - c_custkey
    MAPPING:
    - NAME: c_custkey
      EXPRESSION: c_custkey
  COMMIT:
    MAX_ROW: 1000
    MINIMAL_INTERVAL: 1000
    CONSISTENCY: ATLEAST
  POLL:
    BATCHSIZE: 1000
    TIMEOUT: 1000
  PROPERTIES:
    group.id: ziyuan_example_01
EOF
}