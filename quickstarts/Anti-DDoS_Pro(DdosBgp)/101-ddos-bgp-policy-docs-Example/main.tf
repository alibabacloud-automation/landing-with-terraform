provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf_exampleacc_bgp32594"
}

variable "policy_name" {
  default = "example_l4_policy"
}

resource "alicloud_ddos_bgp_policy" "default" {
  content {
    enable_defense = "false"
    layer4_rule_list {
      method  = "hex"
      match   = "1"
      action  = "1"
      limited = "0"
      condition_list {
        arg      = "3C"
        position = "1"
        depth    = "2"
      }
      name     = "11"
      priority = "10"
    }
  }

  type        = "l4"
  policy_name = "tf_exampleacc_bgp32594"
}