variable "region" {
  default = "cn-beijing"
}

provider "alicloud" {
  region = var.region
}

# 域名(改为您的域名)
variable "domain_name" {
  type        = string
  default     = "tf-example.com"
  description = "your domain name"
}

# 主机记录
variable "host_record" {
  type        = string
  default     = "image"
  description = "Host Record,like image"
}

resource "random_integer" "example" {
  min = 10000
  max = 99999
}

# 创建存储空间
resource "alicloud_oss_bucket" "example" {
  bucket = "bucket-name-${random_integer.example.result}"
}

# 添加一个加速域名
resource "alicloud_cdn_domain_new" "example" {
  domain_name = format("%s.%s", var.host_record, var.domain_name)
  cdn_type    = "web"
  scope       = "overseas"
  sources {
    content  = format("%s.%s", alicloud_oss_bucket.example.bucket, alicloud_oss_bucket.example.extranet_endpoint)
    type     = "oss"
    priority = "20"
    port     = 80
    weight   = "15"
  }
}

# 域名解析
resource "alicloud_dns_record" "example" {
  name        = var.domain_name
  type        = "CNAME"
  host_record = var.host_record
  value       = alicloud_cdn_domain_new.example.cname
  ttl         = 600
}