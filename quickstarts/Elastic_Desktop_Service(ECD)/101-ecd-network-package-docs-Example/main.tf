provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_ecd_simple_office_sites" "default" {
  status     = "REGISTERED"
  name_regex = "default"
}

resource "alicloud_ecd_network_package" "default" {
  bandwidth      = 10
  office_site_id = data.alicloud_ecd_simple_office_sites.default.ids.0
}