variable "region" {
  default = "cn-beijing"
}
provider "alicloud" {
  region = var.region
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}
module "cr" {
  source  = "roura356a/cr/alicloud"
  version = "1.3.1"
  # 命名空间名称
  namespace = "cr_repo_namespace_auto-${random_integer.default.result}"
  # 授权仓库列表
  repositories = ["one", "two", "three"]
  # 此处为了演示方便，设置了一个低安全性的密码。您在使用此模板时，请务必修改为满足您要求的安全性高的密码
  password = "YourPassword@123"
}
