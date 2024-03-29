variable "name" {
  default = "terraform-example"
}


resource "alicloud_ens_instance" "default" {
  period = 1
  data_disk {
    size     = 20
    category = "cloud_efficiency"
  }
  data_disk {
    size     = 30
    category = "cloud_efficiency"
  }
  data_disk {
    size     = 40
    category = "cloud_efficiency"
  }
  public_ip_identification   = true
  period_unit                = "Month"
  scheduling_strategy        = "Concentrate"
  schedule_area_level        = "Region"
  image_id                   = "centos_6_08_64_20G_alibase_20171208"
  carrier                    = "cmcc"
  instance_type              = "ens.sn1.tiny"
  host_name                  = "exampleHost80"
  password                   = "Example123456@@"
  net_district_code          = "100102"
  internet_charge_type       = "95BandwidthByMonth"
  instance_name              = var.name
  internet_max_bandwidth_out = 100
  ens_region_id              = "cn-wuxi-telecom_unicom_cmcc-2"
  system_disk {
    size = 20
  }
  scheduling_price_strategy = "PriceHighPriority"
  user_data                 = "IyEvYmluL3NoCmVjaG8gIkhlbGxvIFdvcmxkLiAgVGhlIHRpbWUgaXMgbm93ICQoZGF0ZSAtUikhIiB8IHRlZSAvcm9vdC9vdXRwdXQudHh0"
  instance_charge_strategy  = "user"
  payment_type              = "Subscription"
}