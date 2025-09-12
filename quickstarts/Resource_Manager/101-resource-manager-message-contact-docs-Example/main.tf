variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_resource_manager_message_contact" "default" {
  message_types        = ["AccountExpenses"]
  phone_number         = "86-18626811111"
  title                = "TechnicalDirector"
  email_address        = "resourceexample@126.com"
  message_contact_name = "example"
}