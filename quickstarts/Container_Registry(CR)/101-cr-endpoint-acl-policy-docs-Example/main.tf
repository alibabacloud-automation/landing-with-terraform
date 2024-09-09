variable "name" {
  default = "tf-example"
}
resource "alicloud_cr_ee_instance" "default" {
  payment_type   = "Subscription"
  period         = 1
  renewal_status = "ManualRenewal"
  instance_type  = "Advanced"
  instance_name  = var.name
}

data "alicloud_cr_endpoint_acl_service" "default" {
  endpoint_type = "internet"
  enable        = true
  instance_id   = alicloud_cr_ee_instance.default.id
  module_name   = "Registry"
}

resource "alicloud_cr_endpoint_acl_policy" "default" {
  instance_id   = data.alicloud_cr_endpoint_acl_service.default.instance_id
  entry         = "192.168.1.0/24"
  description   = var.name
  module_name   = "Registry"
  endpoint_type = "internet"
}