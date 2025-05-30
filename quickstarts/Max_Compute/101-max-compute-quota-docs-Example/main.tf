variable "name" {
  default = "terraformexample"
}

provider "alicloud" {
  region = "cn-chengdu"
}

variable "part_nick_name" {
  default = "TFTest17292"
}

variable "sub_quota_nickname_3" {
  default = "sub398892"
}

variable "sub_quota_nickname_1" {
  default = "sub129792"
}

variable "sub_quota_nickname_2" {
  default = "sub223192"
}

resource "alicloud_max_compute_quota" "default" {
  payment_type   = "Subscription"
  part_nick_name = var.part_nick_name
  commodity_data = "{\"CU\":80,\"ord_time\":\"1:Month\",\"autoRenew\":false} "
  commodity_code = "odpsplus"
  sub_quota_info_list {
    parameter {
      min_cu              = "10"
      max_cu              = "60"
      enable_priority     = "false"
      force_reserved_min  = "false"
      scheduler_type      = "Fifo"
      single_job_cu_limit = "10"
    }

    nick_name = "os_${var.part_nick_name}"
    type      = "FUXI_OFFLINE"
  }
  sub_quota_info_list {
    parameter {
      min_cu             = "10"
      max_cu             = "10"
      scheduler_type     = "Fair"
      enable_priority    = "false"
      force_reserved_min = "false"
    }

    nick_name = var.sub_quota_nickname_1
    type      = "FUXI_OFFLINE"
  }
  sub_quota_info_list {
    nick_name = var.sub_quota_nickname_2
    type      = "FUXI_OFFLINE"
    parameter {
      min_cu             = "60"
      max_cu             = "60"
      scheduler_type     = "Fair"
      enable_priority    = "true"
      force_reserved_min = "true"
    }

  }
}