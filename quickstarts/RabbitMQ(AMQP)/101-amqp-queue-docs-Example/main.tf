variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_amqp_instance" "default" {
  instance_name         = "${var.name}-${random_integer.default.result}"
  instance_type         = "enterprise"
  max_tps               = 3000
  max_connections       = 2000
  queue_capacity        = 200
  payment_type          = "Subscription"
  renewal_status        = "AutoRenewal"
  renewal_duration      = 1
  renewal_duration_unit = "Year"
  support_eip           = true
}

resource "alicloud_amqp_virtual_host" "default" {
  instance_id       = alicloud_amqp_instance.default.id
  virtual_host_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_amqp_queue" "default" {
  instance_id       = alicloud_amqp_instance.default.id
  virtual_host_name = alicloud_amqp_virtual_host.default.virtual_host_name
  queue_name        = "${var.name}-${random_integer.default.result}"
}