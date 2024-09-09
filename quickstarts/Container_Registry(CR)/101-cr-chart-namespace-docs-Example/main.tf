variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000000
  max = 99999999
}

resource "alicloud_cr_ee_instance" "example" {
  payment_type   = "Subscription"
  period         = 1
  renew_period   = 0
  renewal_status = "ManualRenewal"
  instance_type  = "Advanced"
  instance_name  = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_cr_chart_namespace" "example" {
  instance_id    = alicloud_cr_ee_instance.example.id
  namespace_name = "${var.name}-${random_integer.default.result}"
}