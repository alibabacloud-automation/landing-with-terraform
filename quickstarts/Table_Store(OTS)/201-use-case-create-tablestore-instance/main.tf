variable "name" {
  default = "tf-example"
}

variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region = var.region
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 表格存储实例
resource "alicloud_ots_instance" "default" {
  name        = "${var.name}-${random_integer.default.result}" #实例名称
  description = var.name                                       #实例描述
  accessed_by = "Vpc"                                          #访问实例的网络限制
  tags = {                                                     #实例标签
    Created = "TF"
    For     = "Building table"
  }
}