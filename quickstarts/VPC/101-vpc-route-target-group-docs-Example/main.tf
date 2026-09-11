variable "name" {
  default = "terraform-example"
}

variable "region" {
  default = "cn-wulanchabu"
}

variable "zone_id_1" {
  default = "cn-wulanchabu-b"
}

variable "zone_id_2" {
  default = "cn-wulanchabu-c"
}

provider "alicloud" {
  region = var.region
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "zone_a" {
  vpc_id     = alicloud_vpc.default.id
  zone_id    = var.zone_id_1
  cidr_block = "192.168.0.0/24"
}

resource "alicloud_vswitch" "zone_b" {
  vpc_id     = alicloud_vpc.default.id
  zone_id    = var.zone_id_2
  cidr_block = "192.168.1.0/24"
}

# Active member (zone A): GWLB load balancer + GWLB-type endpoint service +
# service-resource attachment + GatewayLoadBalancer endpoint. The endpoint
# depends_on the service-resource so the GWLB is attached to the service
# before the endpoint is created.
resource "alicloud_gwlb_load_balancer" "active" {
  load_balancer_name = "${var.name}-gwlb-active"
  address_ip_version = "Ipv4"
  vpc_id             = alicloud_vpc.default.id
  zone_mappings {
    vswitch_id = alicloud_vswitch.zone_a.id
    zone_id    = var.zone_id_1
  }
}

resource "alicloud_privatelink_vpc_endpoint_service" "active" {
  auto_accept_connection = true
  service_description    = "${var.name}-eps-active"
  service_resource_type  = "gwlb"
}

resource "alicloud_privatelink_vpc_endpoint_service_resource" "active" {
  resource_id   = alicloud_gwlb_load_balancer.active.id
  resource_type = "gwlb"
  service_id    = alicloud_privatelink_vpc_endpoint_service.active.id
  zone_id       = var.zone_id_1
  dry_run       = "false"
}

resource "alicloud_privatelink_vpc_endpoint" "active" {
  service_id        = alicloud_privatelink_vpc_endpoint_service.active.id
  vpc_endpoint_name = "${var.name}-ep-active"
  vpc_id            = alicloud_vpc.default.id
  service_name      = alicloud_privatelink_vpc_endpoint_service.active.vpc_endpoint_service_name
  endpoint_type     = "GatewayLoadBalancer"
}

# Attach zone A to the GWLB endpoint. The route target group backend looks up
# the member endpoint by zone, so the endpoint must carry a non-empty zone.
resource "alicloud_privatelink_vpc_endpoint_zone" "active" {
  endpoint_id = alicloud_privatelink_vpc_endpoint.active.id
  vswitch_id  = alicloud_vswitch.zone_a.id
}

# Standby member (zone B): identical chain in a different zone so the two
# members satisfy active-standby's two-different-zone rule.
resource "alicloud_gwlb_load_balancer" "standby" {
  load_balancer_name = "${var.name}-gwlb-standby"
  address_ip_version = "Ipv4"
  vpc_id             = alicloud_vpc.default.id
  zone_mappings {
    vswitch_id = alicloud_vswitch.zone_b.id
    zone_id    = var.zone_id_2
  }
}

resource "alicloud_privatelink_vpc_endpoint_service" "standby" {
  auto_accept_connection = true
  service_description    = "${var.name}-eps-standby"
  service_resource_type  = "gwlb"
}

resource "alicloud_privatelink_vpc_endpoint_service_resource" "standby" {
  resource_id   = alicloud_gwlb_load_balancer.standby.id
  resource_type = "gwlb"
  service_id    = alicloud_privatelink_vpc_endpoint_service.standby.id
  zone_id       = var.zone_id_2
  dry_run       = "false"
}

resource "alicloud_privatelink_vpc_endpoint" "standby" {
  service_id        = alicloud_privatelink_vpc_endpoint_service.standby.id
  vpc_endpoint_name = "${var.name}-ep-standby"
  vpc_id            = alicloud_vpc.default.id
  service_name      = alicloud_privatelink_vpc_endpoint_service.standby.vpc_endpoint_service_name
  endpoint_type     = "GatewayLoadBalancer"
}

# Attach zone B to the standby GWLB endpoint (different zone from active).
resource "alicloud_privatelink_vpc_endpoint_zone" "standby" {
  endpoint_id = alicloud_privatelink_vpc_endpoint.standby.id
  vswitch_id  = alicloud_vswitch.zone_b.id
}

# The route target group depends_on both endpoint zones: the backend looks up
# each member endpoint by zone, so the zones must exist before Create is called.
resource "alicloud_vpc_route_target_group" "default" {
  route_target_group_name        = var.name
  route_target_group_description = var.name
  vpc_id                         = alicloud_vpc.default.id
  config_mode                    = "Active-Standby"
  route_target_member_list {
    member_id   = alicloud_privatelink_vpc_endpoint.active.id
    member_type = "GatewayLoadBalancerEndpoint"
    weight      = 100
  }
  route_target_member_list {
    member_id   = alicloud_privatelink_vpc_endpoint.standby.id
    member_type = "GatewayLoadBalancerEndpoint"
    weight      = 0
  }
}