variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "asn" {
  default = "4200000666"
}

resource "alicloud_express_connect_router_express_connect_router" "defaultO8Hcfx" {
  alibaba_side_asn = var.asn
  ecr_name         = var.name
}

resource "alicloud_cen_instance" "defaultQKBiay" {
  cen_instance_name = var.name
}

resource "alicloud_cen_transit_router" "defaultQa94Y1" {
  cen_id              = alicloud_cen_instance.defaultQKBiay.id
  transit_router_name = var.name
}

data "alicloud_account" "current" {
}

resource "alicloud_express_connect_router_tr_association" "defaultedPu6c" {
  association_region_id   = "cn-hangzhou"
  ecr_id                  = alicloud_express_connect_router_express_connect_router.defaultO8Hcfx.id
  cen_id                  = alicloud_cen_instance.defaultQKBiay.id
  transit_router_id       = alicloud_cen_transit_router.defaultQa94Y1.transit_router_id
  transit_router_owner_id = data.alicloud_account.current.id
}

resource "alicloud_cen_transit_router_ecr_attachment" "default" {
  ecr_id                                = alicloud_express_connect_router_express_connect_router.defaultO8Hcfx.id
  cen_id                                = alicloud_express_connect_router_tr_association.defaultedPu6c.cen_id
  transit_router_ecr_attachment_name    = var.name
  transit_router_attachment_description = var.name
  transit_router_id                     = alicloud_cen_transit_router.defaultQa94Y1.transit_router_id
  ecr_owner_id                          = data.alicloud_account.current.id
}