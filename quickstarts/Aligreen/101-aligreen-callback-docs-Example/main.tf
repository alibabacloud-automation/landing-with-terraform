variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_aligreen_callback" "default" {
  callback_url         = "https://www.aliyun.com"
  crypt_type           = "0"
  callback_name        = var.name
  callback_types       = ["machineScan", "selfAudit", "example"]
  callback_suggestions = ["block", "review", "pass"]
}