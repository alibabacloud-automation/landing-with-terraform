provider "alicloud" {
  region = "cn-shanghai"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_vod_domain" "default" {
  domain_name = "example-${random_integer.default.result}.com"
  scope       = "domestic"
  sources {
    source_type    = "domain"
    source_content = "outin-c7405446108111ec9a7100163e0eb78b.oss-cn-beijing.aliyuncs.com"
    source_port    = "443"
  }
  tags = {
    Created = "terraform"
    For     = "example"
  }
}