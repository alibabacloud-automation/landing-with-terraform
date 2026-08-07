variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "default" {
  is_default = false
  cidr_block = "172.16.0.0/16"
  vpc_name   = "example-tf-vpc-deployment"
}

resource "alicloud_vswitch" "default" {
  is_default   = false
  vpc_id       = alicloud_vpc.default.id
  zone_id      = "cn-beijing-g"
  cidr_block   = "172.16.0.0/24"
  vswitch_name = "example-tf-vSwitch-deployment"
}

resource "alicloud_oss_bucket" "default" {
}

resource "alicloud_realtime_compute_vvp_instance" "default" {
  vvp_instance_name = "code-example-tf-deployment"
  storage {
    oss {
      bucket = alicloud_oss_bucket.default.id
    }
  }
  vpc_id      = alicloud_vpc.default.id
  vswitch_ids = ["${alicloud_vswitch.default.id}"]
  resource_spec {
    cpu       = "8"
    memory_gb = "32"
  }
  payment_type = "PayAsYouGo"
  zone_id      = alicloud_vswitch.default.zone_id
}

resource "alicloud_realtime_compute_deployment" "create_Deployment9" {
  deployment_name = "tf-example-deployment-sql-56"
  engine_version  = "vvr-8.0.10-flink-1.17"
  resource_id     = alicloud_realtime_compute_vvp_instance.default.resource_id
  execution_mode  = "STREAMING"
  deployment_target {
    mode = "PER_JOB"
    name = "default-queue"
  }
  namespace = "${alicloud_realtime_compute_vvp_instance.default.vvp_instance_name}-default"
  artifact {
    kind = "SQLSCRIPT"
    sql_artifact {
      sql_script = "create temporary table `datagen` ( id varchar, name varchar ) with ( 'connector' = 'datagen' );  create temporary table `blackhole` ( id varchar, name varchar ) with ( 'connector' = 'blackhole' );  insert into blackhole select * from datagen;"
    }
  }
}

resource "alicloud_realtime_compute_job" "default" {
  local_variables {
    value = "qq"
    name  = "tt"
  }

  restore_strategy {
    kind                 = "NONE"
    job_start_time_in_ms = "1763694521254"
  }

  namespace           = "${alicloud_realtime_compute_vvp_instance.default.vvp_instance_name}-default"
  stop_strategy       = "NONE"
  deployment_id       = alicloud_realtime_compute_deployment.create_Deployment9.deployment_id
  resource_queue_name = "default-queue"
  status {
    current_job_status = "CANCELLED"
  }

  resource_id = alicloud_realtime_compute_vvp_instance.default.resource_id
}