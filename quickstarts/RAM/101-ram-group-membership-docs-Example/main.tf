variable "name" {
  default = "tfexample"
}
resource "alicloud_ram_group" "group" {
  name     = format("%sgroup", var.name)
  comments = "this is a group comments."
}

resource "alicloud_ram_user" "user" {
  name         = format("%suser", var.name)
  display_name = "user_display_name"
  mobile       = "86-18688888888"
  email        = "hello.uuu@aaa.com"
  comments     = "yoyoyo"
}

resource "alicloud_ram_user" "user1" {
  name         = format("%suser1", var.name)
  display_name = "user_display_name1"
  mobile       = "86-18688888889"
  email        = "hello.uuu@aaa.com"
  comments     = "yoyoyo"
}

resource "alicloud_ram_group_membership" "membership" {
  group_name = alicloud_ram_group.group.name
  user_names = [alicloud_ram_user.user.name, alicloud_ram_user.user1.name]
}
