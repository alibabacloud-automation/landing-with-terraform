provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "random_string" "suffix" {
  length  = 8
  lower   = true
  upper   = false
  numeric = false
  special = false
}

locals {
  common_name = random_string.suffix.id
}

resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "vpc-${local.common_name}"
}

resource "alicloud_vswitch" "vswitch_1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "vswitch-1-${local.common_name}"
}

resource "alicloud_vswitch" "vswitch_2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.2.0/24"
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "vswitch-2-${local.common_name}"
}

resource "alicloud_vswitch" "vswitch_3" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.3.0/24"
  zone_id      = data.alicloud_zones.default.zones[1].id
  vswitch_name = "vswitch-3-${local.common_name}"
}

resource "alicloud_vswitch" "vswitch_4" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.4.0/24"
  zone_id      = data.alicloud_zones.default.zones[1].id
  vswitch_name = "vswitch-4-${local.common_name}"
}

resource "alicloud_security_group" "security_group_frontend" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg-fe-${local.common_name}"
}

resource "alicloud_security_group" "security_group_backend" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg-be-${local.common_name}"
}

resource "alicloud_sae_namespace" "sae_namespace" {
  namespace_name            = "sae-ns-${local.common_name}"
  namespace_id              = "${var.region}:${local.common_name}"
  enable_micro_registration = false
}

resource "alicloud_sae_config_map" "nginx_config_map" {
  namespace_id = alicloud_sae_namespace.sae_namespace.namespace_id
  name         = "nginx"
  data = jsonencode({ "default.conf" : <<EOF
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    # error_page  404              /404.html;


    # redirect server error pages to the static page /50x.html
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    location /saeTest/ {
        proxy_pass  http://${alicloud_slb_load_balancer.slb_backend.address}:8080/saeTest/; 
    }
}
EOF

  })

}

resource "alicloud_sae_application" "sae_backend_app" {
  app_name             = "sae-be-${local.common_name}"
  namespace_id         = alicloud_sae_namespace.sae_namespace.id
  auto_config          = false
  vpc_id               = alicloud_vpc.vpc.id
  security_group_id    = alicloud_security_group.security_group_backend.id
  vswitch_id           = "${alicloud_vswitch.vswitch_2.id},${alicloud_vswitch.vswitch_4.id}"
  timezone             = "Asia/Beijing"
  replicas             = "2"
  cpu                  = "500"
  memory               = "2048"
  package_type         = "Image"
  jdk                  = "Dragonwell 21"
  image_url            = "registry.${var.region}.aliyuncs.com/sae-serverless-demo/sae-demo:web-springboot-hellosae-v1.0"
  programming_language = "java"
}

resource "alicloud_slb_load_balancer" "slb_backend" {
  load_balancer_name = "slb-be-${local.common_name}"
  vswitch_id         = alicloud_vswitch.vswitch_2.id
  load_balancer_spec = "slb.s2.small"
  address_type       = "intranet"
}

resource "alicloud_sae_load_balancer_intranet" "sae_slb_backend" {
  app_id          = alicloud_sae_application.sae_backend_app.id
  intranet_slb_id = alicloud_slb_load_balancer.slb_backend.id
  intranet {
    protocol    = "HTTP"
    port        = 8080
    target_port = 8080
  }
}

resource "alicloud_sae_application" "sae_frontend_app" {
  app_name             = "sae-fe-${local.common_name}"
  namespace_id         = alicloud_sae_namespace.sae_namespace.id
  auto_config          = false
  vpc_id               = alicloud_vpc.vpc.id
  security_group_id    = alicloud_security_group.security_group_frontend.id
  vswitch_id           = "${alicloud_vswitch.vswitch_1.id},${alicloud_vswitch.vswitch_3.id}"
  timezone             = "Asia/Beijing"
  replicas             = "2"
  cpu                  = "500"
  memory               = "2048"
  package_type         = "Image"
  image_url            = "registry.${var.region}.aliyuncs.com/sae-serverless-demo/sae-demo:web-dashboard-hellosae-v1.0"
  programming_language = "other"
  config_map_mount_desc_v2 {
    config_map_id = alicloud_sae_config_map.nginx_config_map.id
    mount_path    = "/etc/nginx/conf.d/default.conf"
    key           = "default.conf"
  }
}

resource "alicloud_slb_load_balancer" "slb_frontend" {
  load_balancer_name = "slb-fe-${local.common_name}"
  vswitch_id         = alicloud_vswitch.vswitch_1.id
  load_balancer_spec = "slb.s2.small"
  address_type       = "internet"
}

resource "alicloud_sae_load_balancer_internet" "sae_slb_frontend" {
  app_id          = alicloud_sae_application.sae_frontend_app.id
  internet_slb_id = alicloud_slb_load_balancer.slb_frontend.id
  internet {
    protocol    = "HTTP"
    port        = 80
    target_port = 80
  }
}