variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_ens_instance" "default" {
  system_disk {
    size = "20"
  }
  schedule_area_level        = "Region"
  image_id                   = "centos_6_08_64_20G_alibase_20171208"
  payment_type               = "Subscription"
  instance_type              = "ens.sn1.stiny"
  password                   = "12345678ABCabc"
  amount                     = "1"
  period                     = "1"
  internet_max_bandwidth_out = "10"
  public_ip_identification   = true
  ens_region_id              = "cn-chenzhou-telecom_unicom_cmcc"
  period_unit                = "Month"
}

resource "alicloud_ens_security_group" "default" {
  description         = "InstanceSecurityGroupAttachment_Description"
  security_group_name = var.name

}


resource "alicloud_ens_instance_security_group_attachment" "default" {
  instance_id       = alicloud_ens_instance.default.id
  security_group_id = alicloud_ens_security_group.default.id
}