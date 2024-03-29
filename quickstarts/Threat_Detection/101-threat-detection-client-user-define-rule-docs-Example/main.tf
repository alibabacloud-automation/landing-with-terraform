variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_threat_detection_client_user_define_rule" "default" {
  action_type                  = "0"
  platform                     = "windows"
  registry_content             = "123"
  client_user_define_rule_name = var.name

  parent_proc_path = "/root/bash"
  type             = "5"
  cmdline          = "bash"
  proc_path        = "/root/bash"
  parent_cmdline   = "bash"
  registry_key     = "123"
}