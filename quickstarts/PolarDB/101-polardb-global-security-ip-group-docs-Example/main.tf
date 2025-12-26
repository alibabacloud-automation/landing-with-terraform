variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_polardb_global_security_ip_group" "default" {
  global_ip_list       = "192.168.0.1"
  global_ip_group_name = "example_template"
}