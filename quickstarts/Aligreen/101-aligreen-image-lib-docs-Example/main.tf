variable "name" {
  default = "terraform"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_aligreen_biz_type" "defaultUalunB" {
  biz_type_name = var.name
}


resource "alicloud_aligreen_image_lib" "default" {
  category       = "BLACK"
  enable         = true
  scene          = "PORN"
  image_lib_name = var.name
  biz_types      = [alicloud_aligreen_biz_type.defaultUalunB.biz_type_name]
}