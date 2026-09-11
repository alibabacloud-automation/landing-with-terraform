variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "member_account_ids" {
  description = "The IDs of the member accounts in the resource directory. Multiple IDs must be separated by commas (,)."
  type        = string
}

resource "alicloud_threat_detection_monitor_account" "default" {
  account_ids = var.member_account_ids
}