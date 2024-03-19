provider "alicloud" {
  region = "cn-beijing"
}

variable "name" {
  default = "terraform_example"
}
resource "alicloud_api_gateway_group" "example" {
  name        = var.name
  description = var.name
}

resource "alicloud_api_gateway_api" "example" {
  group_id          = alicloud_api_gateway_group.example.id
  name              = var.name
  description       = var.name
  auth_type         = "APP"
  force_nonce_check = false

  request_config {
    protocol = "HTTP"
    method   = "GET"
    path     = "/example/path"
    mode     = "MAPPING"
  }

  service_type = "HTTP"

  http_service_config {
    address   = "http://apigateway-backend.alicloudapi.com:8080"
    method    = "GET"
    path      = "/web/cloudapi"
    timeout   = 12
    aone_name = "cloudapi-openapi"
  }

  request_parameters {
    name         = "example"
    type         = "STRING"
    required     = "OPTIONAL"
    in           = "QUERY"
    in_service   = "QUERY"
    name_service = "exampleservice"
  }

  stage_names = [
    "RELEASE",
    "TEST",
  ]
}

resource "alicloud_api_gateway_plugin" "example" {
  description = "tf_example"
  plugin_name = "tf_example"
  plugin_data = jsonencode({ "allowOrigins" : "api.foo.com", "allowMethods" : "GET,POST,PUT,DELETE,HEAD,OPTIONS,PATCH", "allowHeaders" : "Authorization,Accept,Accept-Ranges,Cache-Control,Range,Date,Content-Type,Content-Length,Content-MD5,User-Agent,X-Ca-Signature,X-Ca-Signature-Headers,X-Ca-Signature-Method,X-Ca-Key,X-Ca-Timestamp,X-Ca-Nonce,X-Ca-Stage,X-Ca-Request-Mode,x-ca-deviceid", "exposeHeaders" : "Content-MD5,Server,Date,Latency,X-Ca-Request-Id,X-Ca-Error-Code,X-Ca-Error-Message", "maxAge" : 172800, "allowCredentials" : true })
  plugin_type = "cors"
}

resource "alicloud_api_gateway_plugin_attachment" "example" {
  api_id     = alicloud_api_gateway_api.example.api_id
  group_id   = alicloud_api_gateway_group.example.id
  plugin_id  = alicloud_api_gateway_plugin.example.id
  stage_name = "RELEASE"
}