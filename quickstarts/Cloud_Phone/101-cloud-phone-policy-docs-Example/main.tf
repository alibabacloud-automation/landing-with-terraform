variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_cloud_phone_policy" "default" {
  policy_group_name = "NewPolicyName"
  resolution_width  = "720"
  lock_resolution   = "on"
  camera_redirect   = "on"
  resolution_height = "1280"
  clipboard         = "read"
  net_redirect_policy {
    net_redirect    = "on"
    custom_proxy    = "on"
    proxy_type      = "socks5"
    host_addr       = "192.168.12.13"
    port            = "8888"
    proxy_user_name = "user1"
    proxy_password  = "123456"
  }
}