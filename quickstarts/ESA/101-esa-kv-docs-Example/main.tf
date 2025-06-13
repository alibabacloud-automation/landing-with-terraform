resource "alicloud_esa_kv_namespace" "default" {
  description  = "this is a example namespace."
  kv_namespace = "namespace1"
}

resource "alicloud_esa_kv" "default" {
  isbase         = "false"
  expiration_ttl = "360"
  value          = "example_value"
  expiration     = "1690"
  namespace      = alicloud_esa_kv_namespace.default.id
  key            = "example_key"
}