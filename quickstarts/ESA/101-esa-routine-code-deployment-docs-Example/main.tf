variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_esa_routine" "default" {
  name             = var.name
  code             = "addEventListener('fetch', e => e.respondWith(new Response('hello')))"
  code_description = "version 1"
}

resource "alicloud_esa_routine_code_deployment" "default" {
  routine_name = alicloud_esa_routine.default.name
  env          = "staging"
  strategy     = "percentage"
  code_versions {
    code_version = alicloud_esa_routine.default.latest_code_version
    percentage   = 100
  }
}