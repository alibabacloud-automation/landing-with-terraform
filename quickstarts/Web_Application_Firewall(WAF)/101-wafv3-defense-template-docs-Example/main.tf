variable "name" {
  default = "terraform-example"
}

data "alicloud_wafv3_instances" "default" {
}

resource "alicloud_wafv3_defense_template" "default" {
  status                = "1"
  instance_id           = data.alicloud_wafv3_instances.default.ids.0
  defense_template_name = var.name

  template_type                      = "user_custom"
  template_origin                    = "custom"
  defense_scene                      = "antiscan"
  resource_manager_resource_group_id = "example"
  description                        = var.name
}