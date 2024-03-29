provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}


resource "alicloud_eip_segment_address" "default" {
  eip_mask             = "28"
  bandwidth            = "5"
  isp                  = "BGP"
  internet_charge_type = "PayByBandwidth"
  netmode              = "public"
}