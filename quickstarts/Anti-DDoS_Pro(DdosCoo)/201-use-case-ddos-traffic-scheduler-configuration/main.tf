provider "alicloud" {
  region = var.region_id
}

variable "region_id" {
  type    = string
  default = "cn-hangzhou"
}

variable "rule_name" {
  type    = string
  default = "testDDos"
}

variable "rule_type" {
  type    = number
  default = 3
}

variable "rules" {
  type = list(object({
    priority   = number
    region_id  = string
    type       = string
    value      = string
    value_type = number
  }))
  default = [
    {
      priority   = 100
      region_id  = "cn-hangzhou"
      type       = "A"
      value      = "127.0.10.11"
      value_type = 3
    },
    {
      priority   = 50
      region_id  = "cn-hangzhou"
      type       = "A"
      value      = "127.0.10.12"
      value_type = 1
    }
  ]
}

resource "alicloud_ddoscoo_scheduler_rule" "example" {
  rule_name = var.rule_name
  rule_type = var.rule_type

  dynamic "rules" {
    for_each = var.rules
    content {
      priority   = rules.value.priority
      region_id  = rules.value.region_id
      type       = rules.value.type
      value      = rules.value.value
      value_type = rules.value.value_type
    }
  }
}