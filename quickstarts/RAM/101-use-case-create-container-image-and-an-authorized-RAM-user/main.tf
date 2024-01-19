provider "alicloud" {
  region = "cn-beijing"
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
  password     = "YFw7yuc.azaq1@WSX"
}
