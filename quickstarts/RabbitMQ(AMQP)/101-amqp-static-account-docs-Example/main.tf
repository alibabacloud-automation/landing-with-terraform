provider "alicloud" {
  region = "cn-shanghai"
}
variable "access_key" {
  default = "access_key"
}
variable "secret_key" {
  default = "secret_key"
}
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
resource "alicloud_amqp_static_account" "default" {
  instance_id = alicloud_amqp_instance.default.id
  access_key  = var.access_key
  secret_key  = var.secret_key
}