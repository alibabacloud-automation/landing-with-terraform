variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "defaultrqDtGm" {
  description = "1111"
  cidr_block  = "192.168.0.0/16"
  vpc_name    = "pop-example-vpc"
}

resource "alicloud_vswitch" "defaultjUrTYm" {
  vpc_id       = alicloud_vpc.defaultrqDtGm.id
  zone_id      = "cn-hangzhou-j"
  cidr_block   = "192.168.0.0/24"
  vswitch_name = "pop-example-vswitch"
}

resource "alicloud_rocketmq_instance" "defaultKJZNVM" {
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
  network_info {
    vpc_info {
      vpc_id = alicloud_vpc.defaultrqDtGm.id
      vswitches {
        vswitch_id = alicloud_vswitch.defaultjUrTYm.id
      }
    }
    internet_info {
      internet_spec      = "enable"
      flow_out_type      = "payByBandwidth"
      flow_out_bandwidth = "5"
    }
  }
  acl_info {
    default_vpc_auth_free = false
    acl_types             = ["default", "apache_acl"]
  }
}

resource "alicloud_rocketmq_account" "defaultMeNlxe" {
  account_status = "ENABLE"
  instance_id    = alicloud_rocketmq_instance.defaultKJZNVM.id
  username       = "tfexample"
  password       = "123456"
}

resource "alicloud_rocketmq_topic" "defaultVA0zog" {
  instance_id  = alicloud_rocketmq_instance.defaultKJZNVM.id
  message_type = "NORMAL"
  topic_name   = "tfexample"
}

resource "alicloud_rocketmq_acl" "default" {
  actions       = ["Pub", "Sub"]
  instance_id   = alicloud_rocketmq_instance.defaultKJZNVM.id
  username      = alicloud_rocketmq_account.defaultMeNlxe.username
  resource_name = alicloud_rocketmq_topic.defaultVA0zog.topic_name
  resource_type = "Topic"
  decision      = "Deny"
  ip_whitelists = ["192.168.5.5"]
}