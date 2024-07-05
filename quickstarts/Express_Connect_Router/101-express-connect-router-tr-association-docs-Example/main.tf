variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "alowprefix1" {
  default = "10.0.0.0/24"
}

variable "allowprefix2" {
  default = "10.0.1.0/24"
}

variable "allowprefix3" {
  default = "10.0.2.0/24"
}

variable "allowprefix4" {
  default = "10.0.3.0/24"
}

variable "asn" {
  default = "4200001003"
}

resource "alicloud_express_connect_router_express_connect_router" "defaultpX0KlC" {
  alibaba_side_asn = var.asn
}

resource "alicloud_cen_instance" "default418DC9" {
  cen_instance_name = var.name
}

resource "alicloud_cen_transit_router" "defaultRYcjsc" {
  cen_id = alicloud_cen_instance.default418DC9.id
}

data "alicloud_account" "current" {
}

resource "alicloud_express_connect_router_tr_association" "default" {
  ecr_id                  = alicloud_express_connect_router_express_connect_router.defaultpX0KlC.id
  cen_id                  = alicloud_cen_instance.default418DC9.id
  transit_router_owner_id = data.alicloud_account.current.id
  allowed_prefixes = [
    "${var.alowprefix1}",
    "${var.allowprefix3}",
    "${var.allowprefix2}"
  ]
  transit_router_id     = alicloud_cen_transit_router.defaultRYcjsc.transit_router_id
  association_region_id = "cn-hangzhou"
}