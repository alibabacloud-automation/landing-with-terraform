variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = ""
}


resource "alicloud_cloud_firewall_vpc_firewall_control_policy_order" "default" {
  order           = "1"
  vpc_firewall_id = "cen-38mhpjiqwbkfullqdj"
  lang            = "zh"
  acl_uuid        = "b71137c7-23f0-411d-b6a0-8a2f1977fe6f"
}