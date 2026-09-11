variable "name" {
  default = "tfexample-sql-file"
}

resource "alicloud_vpc" "default" {
  is_default = false
  cidr_block = "172.16.0.0/16"
  vpc_name   = var.name
}

resource "alicloud_vswitch" "default" {
  is_default   = false
  vpc_id       = alicloud_vpc.default.id
  zone_id      = "cn-beijing-g"
  cidr_block   = "172.16.0.0/24"
  vswitch_name = var.name
}

resource "alicloud_oss_bucket" "default" {
}

resource "alicloud_realtime_compute_vvp_instance" "default" {
  vvp_instance_name = var.name
  storage {
    oss {
      bucket = alicloud_oss_bucket.default.id
    }
  }
  vpc_id      = alicloud_vpc.default.id
  vswitch_ids = [alicloud_vswitch.default.id]
  resource_spec {
    cpu       = "4"
    memory_gb = "16"
  }
  payment_type = "PayAsYouGo"
  zone_id      = alicloud_vswitch.default.zone_id
}

resource "alicloud_realtime_compute_sql_file" "default" {
  workspace            = alicloud_realtime_compute_vvp_instance.default.resource_id
  namespace            = "${alicloud_realtime_compute_vvp_instance.default.vvp_instance_name}-default"
  name                 = var.name
  sql_script           = "SELECT * FROM `vvp`.`default`.example_table;"
  session_cluster_name = "example-session-cluster"
  description          = "example sql file"
}