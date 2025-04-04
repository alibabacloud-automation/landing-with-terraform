resource "alicloud_api_gateway_group" "default" {
  name        = "tf_example"
  description = "tf_example"
  base_path   = "/"
  user_log_config {
    request_body     = true
    response_body    = true
    query_string     = "*"
    request_headers  = "*"
    response_headers = "*"
    jwt_claims       = "*"
  }
}