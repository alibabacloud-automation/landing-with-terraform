provider "alicloud" {
  region = "cn-shanghai"
}

variable "name" {
  default = "tf-example"
}

variable "virtual_host_name" {
  default = "/"
}

resource "alicloud_amqp_instance" "CreateInstance" {
  renewal_duration      = "1"
  max_tps               = "3000"
  period_cycle          = "Month"
  max_connections       = "2000"
  support_eip           = true
  auto_renew            = false
  renewal_status        = "AutoRenewal"
  period                = "12"
  instance_name         = var.name
  support_tracing       = false
  payment_type          = "Subscription"
  renewal_duration_unit = "Month"
  instance_type         = "enterprise"
  queue_capacity        = "200"
  max_eip_tps           = "128"
  storage_size          = "0"
}

resource "alicloud_amqp_exchange" "default" {
  virtual_host_name  = var.virtual_host_name
  instance_id        = alicloud_amqp_instance.CreateInstance.id
  internal           = "true"
  auto_delete_state  = "false"
  exchange_name      = var.name
  exchange_type      = "X_CONSISTENT_HASH"
  alternate_exchange = "bakExchange"
  x_delayed_type     = "DIRECT"
}