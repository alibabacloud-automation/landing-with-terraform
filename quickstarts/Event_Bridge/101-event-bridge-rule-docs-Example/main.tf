provider "alicloud" {
  region = "eu-central-1"
}

variable "name" {
  default = "tf-example"
}

resource "alicloud_event_bridge_event_bus" "example" {
  event_bus_name = "example_value"
}


data "alicloud_account" "default" {
}

resource "alicloud_mns_queue" "queue" {
  name = var.name
}

locals {
  mns_endpoint = format("acs:mns:eu-central-1:%s:queues/%s", data.alicloud_account.default.id, alicloud_mns_queue.queue.name)
}

resource "alicloud_event_bridge_rule" "example" {
  event_bus_name = alicloud_event_bridge_event_bus.example.id
  rule_name      = var.name
  description    = "tf-example"
  filter_pattern = "{\"source\":[\"crmabc.newsletter\"],\"type\":[\"UserSignUp\", \"UserLogin\"]}"
  targets {
    target_id = "tf-example"
    endpoint  = local.mns_endpoint
    type      = "acs.mns.queue"
    param_list {
      resource_key = "queue"
      form         = "CONSTANT"
      value        = "tf-example-EbRule"
    }
    param_list {
      resource_key = "Body"
      form         = "ORIGINAL"
    }
  }
}
