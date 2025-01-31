variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_max_compute_tunnel_quota_timer" "default" {
  quota_timer {
    begin_time = "00:00"
    end_time   = "01:00"
    tunnel_quota_parameter {
      slot_num                  = "50"
      elastic_reserved_slot_num = "50"
    }
  }
  quota_timer {
    begin_time = "01:00"
    end_time   = "02:00"
    tunnel_quota_parameter {
      slot_num                  = "50"
      elastic_reserved_slot_num = "50"
    }
  }
  quota_timer {
    begin_time = "02:00"
    end_time   = "24:00"
    tunnel_quota_parameter {
      slot_num                  = "50"
      elastic_reserved_slot_num = "50"
    }
  }
  nickname  = "ot_terraform_p"
  time_zone = "Asia/Shanghai"
}