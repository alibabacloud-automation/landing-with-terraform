provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_smartag_flow_log" "example" {
  netflow_server_ip   = "192.168.0.2"
  netflow_server_port = 9995
  netflow_version     = "V9"
  output_type         = "netflow"
}