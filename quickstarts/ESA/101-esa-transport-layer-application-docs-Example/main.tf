variable "name" {
  default = "tf-example"
}

data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
  site_name           = "gositecdn.cn"
}

resource "alicloud_esa_transport_layer_application" "default" {
  record_name               = "resource2.gositecdn.cn"
  site_id                   = data.alicloud_esa_sites.default.sites.0.site_id
  ip_access_rule            = "off"
  ipv6                      = "off"
  cross_border_optimization = "off"
  rules {
    source                      = "1.2.3.4"
    comment                     = "transportLayerApplication"
    edge_port                   = "80"
    source_type                 = "ip"
    protocol                    = "TCP"
    source_port                 = "8080"
    client_ip_pass_through_mode = "off"
  }
}