resource "alicloud_nas_access_group" "foo" {
  access_group_name = "terraform-example"
  access_group_type = "Vpc"
  description       = "terraform-example"
  file_system_type  = "extreme"
}