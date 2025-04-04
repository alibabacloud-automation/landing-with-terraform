variable "name" {
  default = "terraform.com"
}

data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "resource_Site_OriginPool_test" {
  site_name   = var.name
  instance_id = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_edge_container_app" "default" {
  health_check_host       = "example.com"
  health_check_type       = "l7"
  service_port            = "80"
  health_check_interval   = "5"
  edge_container_app_name = "terraform-app"
  health_check_http_code  = "http_2xx"
  health_check_uri        = "/"
  health_check_timeout    = "3"
  health_check_succ_times = "2"
  remarks                 = var.name
  health_check_method     = "HEAD"
  health_check_port       = "80"
  health_check_fail_times = "5"
  target_port             = "3000"
}

resource "alicloud_esa_edge_container_app_record" "default" {
  record_name = "tf.terraform.com"
  site_id     = alicloud_esa_site.resource_Site_OriginPool_test.id
  app_id      = alicloud_esa_edge_container_app.default.id
}