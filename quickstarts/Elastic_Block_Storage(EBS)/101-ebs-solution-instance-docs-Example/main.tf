variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

variable "zone_id" {
  default = "cn-shanghai-l"
}

variable "region_id" {
  default = "cn-shanghai"
}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_ebs_solution_instance" "default" {
  solution_instance_name = var.name
  resource_group_id      = data.alicloud_resource_manager_resource_groups.default.ids.0
  description            = "description"
  solution_id            = "mysql"
  parameters {
    parameter_key   = "zoneId"
    parameter_value = var.zone_id
  }
  parameters {
    parameter_key   = "ecsType"
    parameter_value = "ecs.c6.large"
  }
  parameters {
    parameter_key   = "ecsImageId"
    parameter_value = "CentOS_7"
  }
  parameters {
    parameter_key   = "internetMaxBandwidthOut"
    parameter_value = "100"
  }
  parameters {
    parameter_key   = "internetChargeType"
    parameter_value = "PayByTraffic"
  }
  parameters {
    parameter_key   = "ecsPassword"
    parameter_value = "Ebs12345"
  }
  parameters {
    parameter_key   = "sysDiskType"
    parameter_value = "cloud_essd"
  }
  parameters {
    parameter_key   = "sysDiskPerformance"
    parameter_value = "PL0"
  }
  parameters {
    parameter_key   = "sysDiskSize"
    parameter_value = "40"
  }
  parameters {
    parameter_key   = "dataDiskType"
    parameter_value = "cloud_essd"
  }
  parameters {
    parameter_key   = "dataDiskPerformance"
    parameter_value = "PL0"
  }
  parameters {
    parameter_key   = "dataDiskSize"
    parameter_value = "40"
  }
  parameters {
    parameter_key   = "mysqlVersion"
    parameter_value = "MySQL80"
  }
  parameters {
    parameter_key   = "mysqlUser"
    parameter_value = "root"
  }
  parameters {
    parameter_key   = "mysqlPassword"
    parameter_value = "Ebs12345"
  }
}