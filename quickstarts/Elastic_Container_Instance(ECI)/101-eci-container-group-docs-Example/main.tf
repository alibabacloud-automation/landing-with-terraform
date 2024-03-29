provider "alicloud" {
  region = "cn-beijing"
}
variable "name" {
  default = "tf-example"
}

data "alicloud_eci_zones" "default" {}
resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.0.0.0/8"
}
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.1.0.0/16"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_eci_zones.default.zones.0.zone_ids.0
}
resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_eci_container_group" "default" {
  container_group_name = var.name
  cpu                  = 8.0
  memory               = 16.0
  restart_policy       = "OnFailure"
  security_group_id    = alicloud_security_group.default.id
  vswitch_id           = alicloud_vswitch.default.id
  auto_create_eip      = true
  tags = {
    Created = "TF",
    For     = "example",
  }

  containers {
    image             = "registry.cn-beijing.aliyuncs.com/eci_open/nginx:alpine"
    name              = "nginx"
    working_dir       = "/tmp/nginx"
    image_pull_policy = "IfNotPresent"
    commands          = ["/bin/sh", "-c", "sleep 9999"]
    volume_mounts {
      mount_path = "/tmp/example"
      read_only  = false
      name       = "empty1"
    }
    ports {
      port     = 80
      protocol = "TCP"
    }
    environment_vars {
      key   = "name"
      value = "nginx"
    }
    liveness_probe {
      period_seconds        = "5"
      initial_delay_seconds = "5"
      success_threshold     = "1"
      failure_threshold     = "3"
      timeout_seconds       = "1"
      exec {
        commands = ["cat /tmp/healthy"]
      }
    }
    readiness_probe {
      period_seconds        = "5"
      initial_delay_seconds = "5"
      success_threshold     = "1"
      failure_threshold     = "3"
      timeout_seconds       = "1"
      exec {
        commands = ["cat /tmp/healthy"]
      }
    }
  }
  init_containers {
    name              = "init-busybox"
    image             = "registry.cn-beijing.aliyuncs.com/eci_open/busybox:1.30"
    image_pull_policy = "IfNotPresent"
    commands          = ["echo"]
    args              = ["hello initcontainer"]
  }
  volumes {
    name = "empty1"
    type = "EmptyDirVolume"
  }
  volumes {
    name = "empty2"
    type = "EmptyDirVolume"
  }
}