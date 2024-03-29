variable "name" {
  default = "tf-example"
}

data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

data "alicloud_kms_keys" "default" {
  status = "Enabled"
}

data "alicloud_zones" "default" {
  available_instance_type = "ecs.g7.xlarge"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/21"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = var.name
}

resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_ecs_key_pair" "default" {
  key_pair_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_ram_role" "default" {
  name        = var.name
  document    = <<EOF
    {
        "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
            "Service": [
                "emr.aliyuncs.com",
                "ecs.aliyuncs.com"
            ]
            }
        }
        ],
        "Version": "1"
    }
    EOF
  description = "this is a role example."
  force       = true
}


resource "alicloud_emrv2_cluster" "default" {
  node_groups {
    vswitch_ids = [
      "${alicloud_vswitch.default.id}"
    ]
    instance_types = [
      "ecs.g7.xlarge"
    ]
    node_count           = "1"
    spot_instance_remedy = "false"
    data_disks {
      count             = "3"
      category          = "cloud_essd"
      size              = "80"
      performance_level = "PL0"
    }

    node_group_name   = "emr-master"
    payment_type      = "PayAsYouGo"
    with_public_ip    = "false"
    graceful_shutdown = "false"
    system_disk {
      category          = "cloud_essd"
      size              = "80"
      performance_level = "PL0"
      count             = "1"
    }

    node_group_type = "MASTER"
  }
  node_groups {
    spot_instance_remedy = "false"
    node_group_type      = "CORE"
    vswitch_ids = [
      "${alicloud_vswitch.default.id}"
    ]
    node_count        = "2"
    graceful_shutdown = "false"
    system_disk {
      performance_level = "PL0"
      count             = "1"
      category          = "cloud_essd"
      size              = "80"
    }

    data_disks {
      count             = "3"
      performance_level = "PL0"
      category          = "cloud_essd"
      size              = "80"
    }

    node_group_name = "emr-core"
    payment_type    = "PayAsYouGo"
    instance_types = [
      "ecs.g7.xlarge"
    ]
    with_public_ip = "false"
  }

  deploy_mode = "NORMAL"
  tags = {
    Created = "TF"
    For     = "example"
  }
  release_version = "EMR-5.10.0"
  applications = [
    "HADOOP-COMMON",
    "HDFS",
    "YARN"
  ]
  node_attributes {
    zone_id              = data.alicloud_zones.default.zones.0.id
    key_pair_name        = alicloud_ecs_key_pair.default.id
    data_disk_encrypted  = "true"
    data_disk_kms_key_id = data.alicloud_kms_keys.default.ids.0
    vpc_id               = alicloud_vpc.default.id
    ram_role             = alicloud_ram_role.default.name
    security_group_id    = alicloud_security_group.default.id
  }

  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.0
  cluster_name      = var.name
  payment_type      = "PayAsYouGo"
  cluster_type      = "DATAFLOW"
}