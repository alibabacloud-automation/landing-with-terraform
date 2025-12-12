variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_cr_ee_instance" "default" {
  payment_type   = "Subscription"
  period         = 1
  renew_period   = 1
  renewal_status = "AutoRenewal"
  instance_type  = "Advanced"
  instance_name  = var.name
}

resource "alicloud_cr_storage_domain_routing_rule" "default" {
  routes {
    instance_domain = "${alicloud_cr_ee_instance.default.instance_name}-registry-vpc.cn-hangzhou.cr.aliyuncs.com"
    storage_domain  = "https://${alicloud_cr_ee_instance.default.id}-registry.oss-cn-hangzhou-internal.aliyuncs.com"
    endpoint_type   = "Internet"
  }
  instance_id = alicloud_cr_ee_instance.default.id
}