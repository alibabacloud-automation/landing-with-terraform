resource "alicloud_amqp_instance" "default" {
  instance_type  = "enterprise"
  max_tps        = 3000
  queue_capacity = 200
  storage_size   = 700
  support_eip    = false
  max_eip_tps    = 128
  payment_type   = "Subscription"
  period         = 1
}

resource "alicloud_amqp_virtual_host" "default" {
  instance_id       = alicloud_amqp_instance.default.id
  virtual_host_name = "tf-example"
}

resource "alicloud_amqp_exchange" "default" {
  auto_delete_state = false
  exchange_name     = "tf-example"
  exchange_type     = "DIRECT"
  instance_id       = alicloud_amqp_instance.default.id
  internal          = false
  virtual_host_name = alicloud_amqp_virtual_host.default.virtual_host_name
}

resource "alicloud_amqp_queue" "example" {
  instance_id       = alicloud_amqp_instance.default.id
  queue_name        = "tf-example"
  virtual_host_name = alicloud_amqp_virtual_host.default.virtual_host_name
}