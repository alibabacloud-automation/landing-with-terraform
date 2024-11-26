# RAM用户登录密码，
variable "password" {
  default = "Test@123456!"
}

# 保存AccessKey的文件名
variable "accesskey_txt_name" {
  default = "accesskey.txt"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# RAM用户
resource "alicloud_ram_user" "user" {
  name = "tf_user_${random_integer.default.result}"
}

# RAM用户登录密码
resource "alicloud_ram_login_profile" "profile" {
  user_name = alicloud_ram_user.user.name
  password  = var.password
}

# RAM用户AccessKey
resource "alicloud_ram_access_key" "ak" {
  user_name   = alicloud_ram_user.user.name
  secret_file = var.accesskey_txt_name
}

# RAM用户组
resource "alicloud_ram_group" "group" {
  name  = "test_ram_group_${random_integer.default.result}"
  force = true
}

# RAM用户组添加RAM用户
resource "alicloud_ram_group_membership" "membership" {
  group_name = alicloud_ram_group.group.name
  user_names = [alicloud_ram_user.user.name]
}