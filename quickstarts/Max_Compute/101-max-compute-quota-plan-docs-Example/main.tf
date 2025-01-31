variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


variable "elastic_reserved_cu" {
  default = "50"
}

resource "alicloud_max_compute_quota_plan" "default" {
  nickname = "os_terrform_p"
  quota {
    parameter {
      elastic_reserved_cu = var.elastic_reserved_cu
    }

    sub_quota_info_list {
      nick_name = "sub_quota"
      parameter {
        min_cu              = "0"
        max_cu              = "20"
        elastic_reserved_cu = var.elastic_reserved_cu
      }

    }
    sub_quota_info_list {
      nick_name = "os_terrform"
      parameter {
        min_cu              = "50"
        max_cu              = "50"
        elastic_reserved_cu = "0"
      }

    }

  }

  plan_name = "quota_plan"
}