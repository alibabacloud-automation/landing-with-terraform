variable "name" {
  default = "terraform-example"
}

resource "alicloud_cms_alarm_contact_group" "default" {
  alarm_contact_group_name = var.name
}

resource "alicloud_cms_dynamic_tag_group" "default" {
  tag_key            = var.name
  contact_group_list = [alicloud_cms_alarm_contact_group.default.id]
  match_express {
    tag_value                = var.name
    tag_value_match_function = "all"
  }
}