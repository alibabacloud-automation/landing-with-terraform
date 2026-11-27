variable "name" {
  default = "tf-prefixlist-example"
}

resource "alicloud_resource_manager_resource_group" "defaultRg" {
  display_name        = "tf-prefixlist-default-rg"
  resource_group_name = var.name
}

resource "alicloud_resource_manager_resource_group" "changeRg" {
  display_name        = "tf-prefixlist-change-rg"
  resource_group_name = "${var.name}1"
}


resource "alicloud_vpc_prefix_list" "default" {
  max_entries             = 50
  resource_group_id       = alicloud_resource_manager_resource_group.defaultRg.id
  prefix_list_description = "test"
  ip_version              = "IPV4"
  prefix_list_name        = var.name
  entrys {
    cidr        = "192.168.0.0/16"
    description = "test"
  }
}