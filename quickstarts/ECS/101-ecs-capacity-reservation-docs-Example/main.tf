data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g5"
}

data "alicloud_zones" "default" {
  available_resource_creation = "Instance"
  available_instance_type     = data.alicloud_instance_types.default.ids.0
}

data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

resource "alicloud_ecs_capacity_reservation" "default" {
  description               = "terraform-example"
  platform                  = "linux"
  capacity_reservation_name = "terraform-example"
  end_time_type             = "Unlimited"
  resource_group_id         = data.alicloud_resource_manager_resource_groups.default.ids.0
  instance_amount           = 1
  instance_type             = data.alicloud_instance_types.default.ids.0
  match_criteria            = "Open"
  tags = {
    Created = "terraform-example"
  }
  zone_ids = [data.alicloud_zones.default.zones[0].id]
}