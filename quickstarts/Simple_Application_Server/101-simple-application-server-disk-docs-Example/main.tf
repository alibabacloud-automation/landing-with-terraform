variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_simple_application_server_instance" "defaultV70JQf" {
  instance_name     = "examplewujie"
  status            = "Running"
  plan_id           = "swas.s1.c2m2s50b3"
  image_id          = "21e9617bd4754f77a090d2fbc94916a4"
  period            = "1"
  data_disk_size    = "0"
  password          = "@3612568Wj"
  payment_type      = "Subscription"
  auto_renew        = true
  auto_renew_period = "1"
}


resource "alicloud_simple_application_server_disk" "default" {
  disk_size   = "20"
  instance_id = alicloud_simple_application_server_instance.defaultV70JQf.id
  remark      = "example"
}