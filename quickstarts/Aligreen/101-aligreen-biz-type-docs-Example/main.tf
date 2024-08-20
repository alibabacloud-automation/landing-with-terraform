variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_aligreen_biz_type" "default" {
  biz_type_name   = var.name
  description     = var.name
  cite_template   = true
  industry_info   = "社交-注册信息-昵称"
  biz_type_import = "1"
}