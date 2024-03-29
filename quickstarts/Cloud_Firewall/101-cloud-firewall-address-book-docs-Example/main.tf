resource "alicloud_cloud_firewall_address_book" "example" {
  description      = "example_value"
  group_name       = "example_value"
  group_type       = "tag"
  tag_relation     = "and"
  auto_add_tag_ecs = 0
  ecs_tags {
    tag_key   = "created"
    tag_value = "tfTestAcc0"
  }
}