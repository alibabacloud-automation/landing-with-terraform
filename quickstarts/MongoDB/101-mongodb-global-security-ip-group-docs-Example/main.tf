variable "name" {
  default = "terraformexample"
}

resource "alicloud_mongodb_global_security_ip_group" "default" {
  global_ig_name          = var.name
  global_security_ip_list = "192.168.1.1,192.168.1.2,192.168.1.3"
}