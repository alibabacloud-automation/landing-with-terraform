variable "name" {
  default = "tf_example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_dcdn_waf_policy" "example" {
  defense_scene = "waf_group"
  policy_name   = "${var.name}_${random_integer.default.result}"
  policy_type   = "custom"
  status        = "on"
}