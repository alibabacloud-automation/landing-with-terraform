provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}

data "alicloud_resource_manager_resource_groups" "default" {
}

data "alicloud_gpdb_zones" "default" {
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}
data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_gpdb_zones.default.ids.0
}

resource "alicloud_gpdb_instance" "default" {
  db_instance_category  = "HighAvailability"
  db_instance_class     = "gpdb.group.segsdx1"
  db_instance_mode      = "StorageElastic"
  description           = var.name
  engine                = "gpdb"
  engine_version        = "6.0"
  zone_id               = data.alicloud_gpdb_zones.default.ids.0
  instance_network_type = "VPC"
  instance_spec         = "2C16G"
  master_node_num       = 1
  payment_type          = "PayAsYouGo"
  private_ip_address    = "1.1.1.1"
  seg_storage_type      = "cloud_essd"
  seg_node_num          = 4
  storage_size          = 50
  vpc_id                = data.alicloud_vpcs.default.ids.0
  vswitch_id            = data.alicloud_vswitches.default.ids[0]
  ip_whitelist {
    security_ip_list = "127.0.0.1"
  }
}

resource "alicloud_gpdb_db_instance_plan" "default" {
  db_instance_plan_name = var.name
  plan_desc             = var.name
  plan_type             = "PauseResume"
  plan_schedule_type    = "Regular"
  plan_start_date       = formatdate("YYYY-MM-DD'T'hh:mm:ss'Z'", timeadd(timestamp(), "1h"))
  plan_end_date         = formatdate("YYYY-MM-DD'T'hh:mm:ss'Z'", timeadd(timestamp(), "24h"))
  plan_config {
    resume {
      plan_cron_time = "0 0 0 1/1 * ? "
    }
    pause {
      plan_cron_time = "0 0 10 1/1 * ? "
    }
  }
  db_instance_id = alicloud_gpdb_instance.default.id

  # for test
  lifecycle {
    ignore_changes = [plan_start_date, plan_end_date]
  }
}