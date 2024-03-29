variable "name" {
  default = "AliyunTerraform"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_resource_manager_account" "default" {
  display_name = "${var.name}-${random_integer.default.result}"
  timeouts {
    delete = "5m"
  }
}

resource "alicloud_cloud_firewall_instance_member" "default" {
  member_desc = "${var.name}-${random_integer.default.result}"
  member_uid  = alicloud_resource_manager_account.default.id
}