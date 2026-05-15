provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_api_gateway_group" "example" {
  name        = "tf-example-api-gateway-group"
  description = "tf-example-api-gateway-group"
}

resource "alicloud_api_gateway_plugin" "example" {
  description = "tf_example"
  plugin_name = "tf-example-api-gateway-plugin"
  plugin_data = jsonencode({ "allowOrigins" : "api.foo.com", "allowMethods" : "GET,POST,PUT,DELETE,HEAD,OPTIONS,PATCH", "allowHeaders" : "Authorization,Accept,Accept-Ranges,Cache-Control,Range,Date,Content-Type,Content-Length,Content-MD5,User-Agent,X-Ca-Signature,X-Ca-Signature-Headers,X-Ca-Signature-Method,X-Ca-Key,X-Ca-Timestamp,X-Ca-Nonce,X-Ca-Stage,X-Ca-Request-Mode,x-ca-deviceid", "exposeHeaders" : "Content-MD5,Server,Date,Latency,X-Ca-Request-Id,X-Ca-Error-Code,X-Ca-Error-Message", "maxAge" : 172800, "allowCredentials" : true })
  plugin_type = "cors"
}

resource "alicloud_api_gateway_group_plugin_attachment" "example" {
  group_id   = alicloud_api_gateway_group.example.id
  plugin_id  = alicloud_api_gateway_plugin.example.id
  stage_name = "RELEASE"
}