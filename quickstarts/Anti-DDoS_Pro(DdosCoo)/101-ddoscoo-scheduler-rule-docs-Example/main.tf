provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}
resource "alicloud_ddoscoo_scheduler_rule" "example" {
  rule_name = var.name
  rule_type = 3
  rules {
    priority   = 100
    region_id  = "cn-hangzhou"
    type       = "A"
    value      = "127.0.0.1"
    value_type = 3
  }
  rules {
    priority   = 50
    region_id  = "cn-hangzhou"
    type       = "A"
    value      = "127.0.0.0"
    value_type = 1
  }
}