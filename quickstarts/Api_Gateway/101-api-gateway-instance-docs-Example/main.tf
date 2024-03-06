variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_api_gateway_instance" "default" {
  instance_name = var.name

  instance_spec = "api.s1.small"
  https_policy  = "HTTPS2_TLS1_0"
  zone_id       = "cn-hangzhou-MAZ6"
  payment_type  = "PayAsYouGo"
  user_vpc_id   = "1709116870"
  instance_type = "normal"
}