variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_ecs_disk" "defaultJkW46o" {
  category          = "cloud_essd"
  description       = "esp-attachment-test"
  zone_id           = "cn-hangzhou-i"
  performance_level = "PL1"
  size              = "20"
  disk_name         = var.name
}

resource "alicloud_ebs_enterprise_snapshot_policy" "defaultPE3jjR" {
  status = "DISABLED"
  desc   = "DESC"
  schedule {
    cron_expression = "0 0 0 1 * ?"
  }
  enterprise_snapshot_policy_name = var.name

  target_type = "DISK"
  retain_rule {
    time_interval = "120"
    time_unit     = "DAYS"
  }
}