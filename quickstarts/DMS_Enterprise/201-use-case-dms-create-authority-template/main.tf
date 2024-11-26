variable "region" {
  default = "cn-heyuan"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "terraform-example"
}
variable "description" {
  default = "For terraform"
}
# 获取DMS用户租户
data "alicloud_dms_user_tenants" "default" {
  status = "ACTIVE"
}
# 创建权限模板
resource "alicloud_dms_enterprise_authority_template" "default" {
  # 租户id
  tid = data.alicloud_dms_user_tenants.default.ids.0
  # （必填）权限模板名称
  authority_template_name = var.name
  # 描述
  description = var.description
}