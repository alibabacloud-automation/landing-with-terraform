variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "region_id" {
  default = "cn-hangzhou"
}

resource "alicloud_wafv3_instance" "defaultHaF1fD" {
}

resource "alicloud_wafv3_domain" "defaultHVcskT" {
  instance_id = alicloud_wafv3_instance.defaultHaF1fD.id
  listen {
    http_ports = ["80"]
  }
  redirect {
    backends    = ["6.36.36.36"]
    loadbalance = "iphash"
  }
  domain      = "1511928242963727_1.wafqax.top"
  access_type = "share"
}

resource "alicloud_wafv3_domain" "defaultEH4CwO" {
  instance_id = alicloud_wafv3_instance.defaultHaF1fD.id
  listen {
    http_ports = ["80"]
  }
  redirect {
    backends    = ["6.36.36.36"]
    loadbalance = "iphash"
  }
  domain      = "1511928242963727_2.wafqax.top"
  access_type = "share"
}

resource "alicloud_wafv3_domain" "defaultY0ge1N" {
  instance_id = alicloud_wafv3_instance.defaultHaF1fD.id
  listen {
    http_ports = ["80"]
  }
  redirect {
    backends    = ["6.36.36.36"]
    loadbalance = "iphash"
  }
  domain      = "1511928242963727_3.wafqax.top"
  access_type = "share"
}


resource "alicloud_wafv3_defense_resource_group" "default" {
  group_name    = "examplefromTF"
  resource_list = ["${alicloud_wafv3_domain.defaultHVcskT.domain_id}"]
  description   = "example"
  instance_id   = alicloud_wafv3_instance.defaultHaF1fD.id
}