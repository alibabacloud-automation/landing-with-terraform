data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g6"
}

resource "alicloud_reserved_instance" "default" {
  instance_type          = data.alicloud_instance_types.default.instance_types.0.id
  instance_amount        = "1"
  period_unit            = "Month"
  offering_type          = "All Upfront"
  reserved_instance_name = "terraform-example"
  description            = "ReservedInstance"
  zone_id                = data.alicloud_instance_types.default.instance_types.0.availability_zones.0
  scope                  = "Zone"
}