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

resource "alicloud_api_gateway_app" "example" {
  name        = var.name
  description = var.name
}

resource "alicloud_api_gateway_app_attachment" "example" {
  api_id     = alicloud_api_gateway_api.example.api_id
  group_id   = alicloud_api_gateway_group.example.id
  app_id     = alicloud_api_gateway_app.example.id
  stage_name = "PRE"
}