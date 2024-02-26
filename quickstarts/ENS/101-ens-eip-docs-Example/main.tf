variable "name" {
  default = "terraform-example"
}

resource "alicloud_ens_eip" "default" {
  description   = "EipDescription_autotest"
  bandwidth     = "5"
  isp           = "cmcc"
  payment_type  = "PayAsYouGo"
  ens_region_id = "cn-chenzhou-telecom_unicom_cmcc"
  eip_name      = var.name

  internet_charge_type = "95BandwidthByMonth"
}