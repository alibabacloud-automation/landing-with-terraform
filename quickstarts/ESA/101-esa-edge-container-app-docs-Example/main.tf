variable "name" {
  default = "tfexample"
}

resource "alicloud_esa_edge_container_app" "default" {
  target_port             = "3000"
  health_check_host       = "example.com"
  remarks                 = var.name
  health_check_port       = "80"
  health_check_uri        = "/"
  health_check_timeout    = "3"
  health_check_method     = "HEAD"
  health_check_http_code  = "http_2xx"
  health_check_fail_times = "5"
  service_port            = "80"
  health_check_interval   = "5"
  health_check_succ_times = "2"
  edge_container_app_name = var.name
  health_check_type       = "l7"
}