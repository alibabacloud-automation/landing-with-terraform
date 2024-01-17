provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_api_gateway_group" "example" {
  name        = "tf-example"
  description = "tf-example"
}

resource "alicloud_api_gateway_api" "example" {
  group_id          = alicloud_api_gateway_group.example.id
  name              = "tf-example"
  description       = "tf-example"
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