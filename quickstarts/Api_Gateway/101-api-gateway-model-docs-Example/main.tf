resource "alicloud_api_gateway_group" "default" {
  name        = "example_value"
  description = "example_value"
}

resource "alicloud_api_gateway_model" "default" {
  group_id    = alicloud_api_gateway_group.default.id
  model_name  = "example_value"
  schema      = "{\"type\":\"object\",\"properties\":{\"id\":{\"format\":\"int64\",\"maximum\":100,\"exclusiveMaximum\":true,\"type\":\"integer\"},\"name\":{\"maxLength\":10,\"type\":\"string\"}}}"
  description = "example_value"
}