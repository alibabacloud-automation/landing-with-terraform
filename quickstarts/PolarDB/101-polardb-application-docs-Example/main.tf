resource "alicloud_vpc" "default" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = "cn-beijing-k"
  vswitch_name = "terraform-example"
}

resource "alicloud_polardb_cluster" "default" {
  db_type     = "MySQL"
  db_version  = "8.0"
  pay_type    = "PostPaid"
  category    = "Normal"
  description = "terraform-example-cluster"
}

resource "alicloud_polardb_application" "default" {
  description      = "terraform-example-app"
  application_type = "polarclaw"
  architecture     = "x86"
  db_cluster_id    = alicloud_polardb_cluster.default.id
  vswitch_id       = alicloud_vswitch.default.id
  vpc_id           = alicloud_vpc.default.id
  region_id        = "cn-beijing"
  zone_id          = "cn-beijing-k"
  pay_type         = "PostPaid"
  model_from       = "bailian"
  model_base_url   = "https://dashscope.aliyuncs.com/compatible-mode/v1"
  model_name       = "qwen3.6-plus"

  components {
    component_type    = "polarclaw_comp"
    component_class   = "polar.app.g2.medium"
    component_replica = 1
  }

  parameters {
    parameter_name  = "secret.dashscope.apiKey"
    parameter_value = "ap-xxx"
  }

  modify_mode            = "Append"
  security_ip_array_name = "white_list"
  security_ip_list       = ["127.0.0.1", "192.168.1.2"]
}