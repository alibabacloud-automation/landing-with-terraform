variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}


resource "alicloud_amqp_instance" "default" {
  instance_name  = var.name
  instance_type  = "professional"
  max_tps        = "1000"
  queue_capacity = "50"
  period_cycle   = "Year"
  support_eip    = "false"
  period         = "1"
  auto_renew     = "true"
  payment_type   = "Subscription"
}