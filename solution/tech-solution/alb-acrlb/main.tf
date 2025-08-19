# Provider 配置
provider "alicloud" {
  alias  = "region1"
  region = var.region1
}

provider "alicloud" {
  alias  = "region2"
  region = var.region2
}

provider "alicloud" {
  alias  = "region3"
  region = var.region3
}