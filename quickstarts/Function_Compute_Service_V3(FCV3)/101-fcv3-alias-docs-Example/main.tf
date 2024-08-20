variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "function_name" {
  default = "flask-3xdg"
}


resource "alicloud_fcv3_alias" "default" {
  version_id    = "1"
  function_name = var.function_name
  description   = "create alias"
  alias_name    = var.name
  additional_version_weight = {
    "2" = "0.5"
  }
}