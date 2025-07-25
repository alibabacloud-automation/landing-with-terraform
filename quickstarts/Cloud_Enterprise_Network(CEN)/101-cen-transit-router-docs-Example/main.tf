variable "name" {
  default = "terraform-example"
}

resource "alicloud_cen_instance" "example" {
  cen_instance_name = var.name
  description       = var.name
}

resource "alicloud_cen_transit_router" "example" {
  cen_id              = alicloud_cen_instance.example.id
  transit_router_name = var.name
}