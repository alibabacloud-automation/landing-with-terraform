variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_ens_disk" "default" {
  size          = "20"
  ens_region_id = "cn-chenzhou-telecom_unicom_cmcc"
  payment_type  = "PayAsYouGo"
  category      = "cloud_efficiency"
}

resource "alicloud_ens_instance" "default" {
  system_disk {
    size = "20"
  }
  image_id                   = "centos_6_08_64_20G_alibase_20171208"
  payment_type               = "Subscription"
  instance_type              = "ens.sn1.stiny"
  password                   = "12345678ABCabc"
  amount                     = "1"
  internet_max_bandwidth_out = "10"
  unique_suffix              = true
  public_ip_identification   = true
  ens_region_id              = "cn-chenzhou-telecom_unicom_cmcc"
  schedule_area_level        = "Region"
  period_unit                = "Month"
  period                     = "1"
  timeouts {
    delete = "50m"
  }
}


resource "alicloud_ens_disk_instance_attachment" "default" {
  instance_id          = alicloud_ens_instance.default.id
  delete_with_instance = "false"
  disk_id              = alicloud_ens_disk.default.id
}