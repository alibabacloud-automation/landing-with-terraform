variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "defaultg6ZXs2" {
  description = "111"
  cidr_block  = "192.168.0.0/16"
  vpc_name    = "pop-example-vpc"
}

resource "alicloud_vswitch" "defaultvMQbCy" {
  vpc_id       = alicloud_vpc.defaultg6ZXs2.id
  zone_id      = "cn-hangzhou-j"
  cidr_block   = "192.168.0.0/24"
  vswitch_name = "pop-example-vswitch"
}

resource "alicloud_rocketmq_instance" "default9hAb83" {
  product_info {
    msg_process_spec       = "rmq.p2.4xlarge"
    send_receive_ratio     = "0.3"
    message_retention_time = "70"
  }
  service_code    = "rmq"
  series_code     = "professional"
  payment_type    = "PayAsYouGo"
  instance_name   = var.name
  sub_series_code = "cluster_ha"
  remark          = "example"
  software {
    maintain_time = "02:00-06:00"
  }
  tags = {
    Created = "TF"
    For     = "example"
  }
  network_info {
    vpc_info {
      vpc_id = alicloud_vpc.defaultg6ZXs2.id
      vswitches {
        vswitch_id = alicloud_vswitch.defaultvMQbCy.id
      }
    }
    internet_info {
      internet_spec      = "enable"
      flow_out_type      = "payByBandwidth"
      flow_out_bandwidth = "30"
    }
  }
  acl_info {
    default_vpc_auth_free = false
    acl_types             = ["default", "apache_acl"]
  }
}

resource "alicloud_rocketmq_account" "default" {
  account_status = "ENABLE"
  instance_id    = alicloud_rocketmq_instance.default9hAb83.id
  username       = "tfexample"
  password       = "1741835136"
}