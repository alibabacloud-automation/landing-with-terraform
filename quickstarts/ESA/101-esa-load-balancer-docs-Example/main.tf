variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_esa_site" "resource_Site_OriginPool" {
  site_name   = "${var.name}${random_integer.default.result}.com"
  instance_id = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_origin_pool" "resource_OriginPool_LoadBalancer_1_1" {
  origins {
    type    = "ip_domain"
    address = "www.example.com"
    header  = "{\"Host\":[\"www.example.com\"]}"
    enabled = true
    weight  = "30"
    name    = "origin1"
  }
  site_id          = alicloud_esa_site.resource_Site_OriginPool.id
  origin_pool_name = "originpool1"
  enabled          = true
}

resource "alicloud_esa_load_balancer" "default" {
  load_balancer_name = "lb.exampleloadbalancer.top"
  fallback_pool      = alicloud_esa_origin_pool.resource_OriginPool_LoadBalancer_1_1.origin_pool_id
  site_id            = alicloud_esa_site.resource_Site_OriginPool.id
  description        = var.name
  default_pools      = [alicloud_esa_origin_pool.resource_OriginPool_LoadBalancer_1_1.origin_pool_id]
  steering_policy    = "geo"
  monitor {
    type              = "ICMP Ping"
    timeout           = 5
    monitoring_region = "ChineseMainland"
    consecutive_up    = 3
    consecutive_down  = 5
    interval          = 60
  }
}