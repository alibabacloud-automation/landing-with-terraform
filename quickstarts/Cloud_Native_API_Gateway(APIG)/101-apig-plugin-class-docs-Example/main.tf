variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_apig_plugin_class" "default" {
  wasm_url                      = "https://example.com/plugin.wasm"
  description                   = "A example plugin class for CloudSpec coverage"
  version_description           = "Initial version for exampleing"
  plugin_class_name             = "example-plugin-class-cspec-v3"
  version                       = "1.0.2"
  alias                         = "example-plugin-alias-v3"
  execute_priority              = "1"
  wasm_language                 = "TinyGo"
  supported_min_gateway_version = "1.0.0"
  execute_stage                 = "UNSPECIFIED_PHASE"
}