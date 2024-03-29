provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "tf-example"
}

data "alicloud_account" "default" {
}

resource "alicloud_event_bridge_event_bus" "default" {
  event_bus_name = var.name
}

resource "alicloud_mns_queue" "queue1" {
  name = var.name
}

locals {
  mns_endpoint_a = format("acs:mns:cn-hangzhou:%s:queues/%s", data.alicloud_account.default.id, alicloud_mns_queue.queue1.name)
  fnf_endpoint   = format("acs:fnf:cn-hangzhou:%s:flow/$${flow}", data.alicloud_account.default.id)
}
resource "alicloud_event_bridge_rule" "example" {
  event_bus_name = alicloud_event_bridge_event_bus.default.event_bus_name
  rule_name      = var.name
  description    = "example"
  filter_pattern = "{\"source\":[\"crmabc.newsletter\"],\"type\":[\"UserSignUp\", \"UserLogin\"]}"
  targets {
    target_id = "tf-example1"
    endpoint  = local.mns_endpoint_a
    type      = "acs.mns.queue"
    param_list {
      resource_key = "queue"
      form         = "CONSTANT"
      value        = "tf-testaccEbRule"
    }
    param_list {
      resource_key = "Body"
      form         = "ORIGINAL"
    }
    param_list {
      form         = "CONSTANT"
      resource_key = "IsBase64Encode"
      value        = "true"

    }
  }
}