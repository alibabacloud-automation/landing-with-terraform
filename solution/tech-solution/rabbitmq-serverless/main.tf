provider "alicloud" {
  region = var.region
}

resource "random_string" "suffix" {
  length  = 8
  lower   = true
  upper   = false
  numeric = false
  special = false
}

locals {
  common_name = random_string.suffix.id
}

resource "alicloud_ram_user" "ram_user" {
  name = "create-by-solution-${local.common_name}"
}

resource "alicloud_ram_access_key" "ramak" {
  user_name = alicloud_ram_user.ram_user.name
}

resource "alicloud_ram_policy" "policy" {
  policy_name     = "ram-policy-${local.common_name}"
  policy_document = <<EOF
  {
    "Version": "1",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "amqp:*",
          "amqp-open:*"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
  description     = "allow all amqp operations"
}

resource "alicloud_ram_user_policy_attachment" "attach_policy_to_user" {
  user_name   = alicloud_ram_user.ram_user.name
  policy_type = "Custom"
  policy_name = alicloud_ram_policy.policy.policy_name
}

resource "alicloud_amqp_instance" "default" {
  instance_name          = "test-instance-${local.common_name}"
  payment_type           = "PayAsYouGo"
  serverless_charge_type = "onDemand"
  support_eip            = true
  support_tracing        = true
}

resource "alicloud_amqp_static_account" "default" {
  instance_id = alicloud_amqp_instance.default.id
  access_key  = alicloud_ram_access_key.ramak.id
  secret_key  = alicloud_ram_access_key.ramak.secret
}

resource "alicloud_amqp_virtual_host" "default" {
  instance_id       = alicloud_amqp_instance.default.id
  virtual_host_name = "test-vhost-${local.common_name}"
}

resource "alicloud_amqp_exchange" "default" {
  virtual_host_name = alicloud_amqp_virtual_host.default.virtual_host_name
  instance_id       = alicloud_amqp_instance.default.id
  internal          = false
  auto_delete_state = false
  exchange_name     = "test-exchange-${local.common_name}"
  exchange_type     = "DIRECT"
}

resource "alicloud_amqp_queue" "default" {
  instance_id       = alicloud_amqp_instance.default.id
  queue_name        = "test-queue-${local.common_name}"
  virtual_host_name = alicloud_amqp_virtual_host.default.virtual_host_name
  auto_delete_state = false
}

resource "alicloud_amqp_binding" "default" {
  binding_key       = "binding-key-${local.common_name}"
  binding_type      = "QUEUE"
  destination_name  = alicloud_amqp_queue.default.queue_name
  instance_id       = alicloud_amqp_instance.default.id
  source_exchange   = alicloud_amqp_exchange.default.exchange_name
  virtual_host_name = alicloud_amqp_virtual_host.default.virtual_host_name
}