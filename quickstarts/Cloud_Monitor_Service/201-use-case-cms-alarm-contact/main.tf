variable "region" {
  default = "cn-heyuan"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "tf_example"
}
variable "describe" {
  default = "For example"
}
variable "mail" {
  default = "username@example.com"
}
resource "alicloud_cms_alarm_contact" "example" {
  #（必需，强制新建）报警联系人的名称。长度应在 2 到 40 个字符之间。
  alarm_contact_name = var.name
  # （必需）报警联系人的描述。
  describe = var.describe
  # （可选）报警联系人的电子邮件地址。
  channels_mail = var.mail
  # channels_sms （可选）报警联系人的电话号码。
  # channels_sms     =    "193****1234"
  # 在未激活链接前，邮件地址不会生效，Terraform会检测当前模版会存在属性 diff，通过以下方式可暂时忽略。
  lifecycle {
    ignore_changes = [channels_mail]
  }
}