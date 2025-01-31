variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "elastic_reserved_cu" {
  default = "0"
}

variable "quota_nick_name" {
  default = "os_terrform_p"
}

resource "alicloud_max_compute_quota_plan" "default" {
  quota {
    parameter {
      elastic_reserved_cu = 50
    }
    sub_quota_info_list {
      nick_name = "sub_quota"
      parameter {
        min_cu              = "0"
        max_cu              = "20"
        elastic_reserved_cu = "30"
      }
    }
    sub_quota_info_list {
      nick_name = "os_terrform"
      parameter {
        min_cu              = "50"
        max_cu              = "50"
        elastic_reserved_cu = "20"
      }

    }
  }

  plan_name = "quota_plan1"
  nickname  = "os_terrform_p"
}

resource "alicloud_max_compute_quota_plan" "default2" {
  quota {
    parameter {
      elastic_reserved_cu = 50
    }
    sub_quota_info_list {
      nick_name = "sub_quota"
      parameter {
        min_cu              = "0"
        max_cu              = "20"
        elastic_reserved_cu = "20"
      }
    }
    sub_quota_info_list {
      nick_name = "os_terrform"
      parameter {
        min_cu              = "50"
        max_cu              = "50"
        elastic_reserved_cu = "30"
      }

    }
  }

  plan_name = "quota_plan2"
  nickname  = "os_terrform_p"
}

resource "alicloud_max_compute_quota_plan" "default3" {
  quota {
    parameter {
      elastic_reserved_cu = 50
    }
    sub_quota_info_list {
      nick_name = "sub_quota"
      parameter {
        min_cu              = "40"
        max_cu              = "40"
        elastic_reserved_cu = "40"
      }
    }
    sub_quota_info_list {
      nick_name = "os_terrform"
      parameter {
        min_cu              = "10"
        max_cu              = "10"
        elastic_reserved_cu = "10"
      }

    }
  }

  plan_name = "quota_plan3"
  nickname  = "os_terrform_p"
}

resource "alicloud_max_compute_quota_schedule" "default" {
  timezone = "UTC+8"
  nickname = var.quota_nick_name
  schedule_list {
    plan = "Default"
    condition {
      at = "00:00"
    }

    type = "daily"
  }

  # schedule_list {
  #   plan = "${alicloud_max_compute_quota_plan.default.plan_name}"
  #     condition {
  #     at = "00:00"
  #   }

  #   type = "daily"
  # }
  # schedule_list {
  #   type = "daily"
  #   plan = "${alicloud_max_compute_quota_plan.default2.plan_name}"
  #     condition {
  #     at = "01:00"
  #   }

  # }
  # schedule_list {
  #   plan = "${alicloud_max_compute_quota_plan.default3.plan_name}"
  #     condition {
  #     at = "02:00"
  #   }

  #   type = "daily"
  # }

}