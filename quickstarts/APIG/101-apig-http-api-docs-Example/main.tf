variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "protocol" {
  default = "HTTP"
}

variable "protocol_https" {
  default = "HTTPS"
}

data "alicloud_resource_manager_resource_groups" "default" {}


resource "alicloud_apig_http_api" "default" {
  http_api_name = var.name
  protocols     = ["${var.protocol}"]
  base_path     = "/v1"
  description   = "zhiwei_pop_examplecase"
  type          = "Rest"
}