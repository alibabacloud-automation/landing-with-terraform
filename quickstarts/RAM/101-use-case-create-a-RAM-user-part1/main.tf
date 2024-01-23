resource "alicloud_ram_user" "user" {
  name         = "user_test"
  display_name = "TestAccount"
  mobile       = "86-18688888888"
  email        = "example@example.com"
  comments     = "yoyoyo"
  force        = true
}

resource "alicloud_ram_login_profile" "profile" {
  user_name = alicloud_ram_user.user.name
  password  = "!Test@123456"
}

resource "alicloud_ram_access_key" "ak" {
  user_name   = alicloud_ram_user.user.name
  secret_file = "accesskey.txt" # 保存AccessKey的文件名
}

resource "alicloud_ram_group" "group" {
  name  = "test_ram_group"
  force = true
}

resource "alicloud_ram_group_membership" "membership" {
  group_name = alicloud_ram_group.group.name
  user_names = [alicloud_ram_user.user.name]
}