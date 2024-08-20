variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "ens_region_id" {
  default = "cn-chenzhou-telecom_unicom_cmcc"
}

resource "alicloud_ens_instance" "defaultXKjq1W" {
  system_disk {
    size     = "20"
    category = "cloud_efficiency"
  }
  scheduling_strategy      = "Concentrate"
  schedule_area_level      = "Region"
  image_id                 = "centos_6_08_64_20G_alibase_20171208"
  payment_type             = "Subscription"
  instance_type            = "ens.sn1.stiny"
  password                 = "12345678abcABC"
  status                   = "Running"
  amount                   = "1"
  internet_charge_type     = "95BandwidthByMonth"
  instance_name            = var.name
  auto_use_coupon          = "true"
  instance_charge_strategy = "PriceHighPriority"
  ens_region_id            = var.ens_region_id
  period_unit              = "Month"
}

resource "alicloud_ens_eip" "defaultsGsN4e" {
  bandwidth            = "5"
  eip_name             = var.name
  ens_region_id        = var.ens_region_id
  internet_charge_type = "95BandwidthByMonth"
  payment_type         = "PayAsYouGo"
}

resource "alicloud_ens_eip_instance_attachment" "default" {
  instance_id   = alicloud_ens_instance.defaultXKjq1W.id
  allocation_id = alicloud_ens_eip.defaultsGsN4e.id
  instance_type = "EnsInstance"
  standby       = "false"
}