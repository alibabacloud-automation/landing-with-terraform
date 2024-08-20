variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_aligreen_audit_callback" "default" {
  crypt_type           = "SM3"
  audit_callback_name  = var.name
  url                  = "https://www.aliyun.com/"
  callback_types       = ["aliyunAudit", "selfAduit", "example"]
  callback_suggestions = ["block", "review", "pass"]
}