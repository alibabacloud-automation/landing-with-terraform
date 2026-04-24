variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = ""
}


resource "alicloud_cloud_firewall_nat_firewall_control_policy_order" "default" {
  acl_uuid       = "a3b5e8f3-6d2c-4e26-b078-87cee0790106"
  nat_gateway_id = "ngw-2ze8hqi59w9wrm30zwgnq"
  direction      = "out"
  order          = "1"
}