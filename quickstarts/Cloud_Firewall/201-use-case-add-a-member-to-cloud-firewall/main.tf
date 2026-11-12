variable "name" {
  default = "tf-example"
}
variable "display_name" {
  default = "EAccount"
}
# 随机数
resource "random_integer" "default" {
  min = 10000
  max = 99999
}
data "alicloud_resource_manager_folders" "example" {
}
# 资源管理账户
resource "alicloud_resource_manager_account" "default" {
  # 成员名字
  display_name = "${var.display_name}-${random_integer.default.result}"
  # 父文件夹ID 可选
  folder_id = data.alicloud_resource_manager_folders.example.ids.0
}
# 添加云防火墙成员
resource "alicloud_cloud_firewall_instance_member" "default" {
  # 云防火墙成员账户的备注。
  member_desc = "${var.name}-${random_integer.default.result}"
  # 云防火墙成员账户的 UID
  member_uid = alicloud_resource_manager_account.default.id
}