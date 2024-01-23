module "ram_user" {
  // 引用module源地址
  source = "terraform-alicloud-modules/ram/alicloud"
  // RAM用户名
  name = "terraformtest1"
  // 是否创建控制台登录凭证
  create_ram_user_login_profile = false
  // 是否创建accesskey
  create_ram_access_key = false
  // 是否赋予管理员权限
  is_admin = false
}