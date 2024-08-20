variable "name" {
  default = "terraform"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_aligreen_biz_type" "defaultMn8sVK" {
  biz_type_name = "${var.name}${random_integer.default.result}"
  cite_template = true
  industry_info = "社交-注册信息-昵称"
}


resource "alicloud_aligreen_keyword_lib" "default" {
  category         = "BLACK"
  resource_type    = "TEXT"
  lib_type         = "textKeyword"
  keyword_lib_name = var.name
  match_mode       = "fuzzy"
  language         = "cn"
  biz_types        = ["example_007"]
  lang             = "cn"
  enable           = true
}