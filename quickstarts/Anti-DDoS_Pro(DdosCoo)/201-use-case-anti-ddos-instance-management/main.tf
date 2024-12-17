# 区域
variable "region_id" {
  type    = string
  default = "ap-southeast-1" # 修改为 新加坡
}

# DDoS CoO 实例名称
variable "ddoscoo_instance_name" {
  description = "The name of the DDoS CoO instance"
  type        = string
  default     = "Ddoscoo-spm-fofo" # 默认值
}
# 端口数量（必需）实例的端口重传规则数量。至少为50。每次增加5，例如55、60、65。仅支持升级。
variable "port_count" {
  description = "Number of ports for the DDoS CoO instance"
  type        = string
  default     = "50" # 默认值
}
#0：保险防护    #1：无限防护   #2：中国大陆加速线路。 #3：安全中国大陆加速（Sec-CMA）缓解计划。
variable "product_plan" {
  description = "Product plan of the DDoS CoO instance"
  type        = string
  default     = "0"
}

# 域名数量（必需）实例的域名重传规则数量。至少为50。每次增加5，例如55、60、65。仅支持升级。
variable "domain_count" {
  description = "Number of domains for the DDoS CoO instance"
  type        = string
  default     = "50" # 默认值
}

# 购买周期
variable "period" {
  description = "Purchase period of the DDoS CoO instance"
  type        = string
  default     = "1" # 默认值
}

# 产品类型
variable "product_type" {
  description = "Product type of the DDoS CoO instance"
  type        = string
  default     = "ddosDip" #  国际版 ddoscoo_intl
}

# 计费模式
variable "pricing_mode" {
  description = "Pricing mode of the DDoS CoO instance (Prepaid or Postpaid)"
  type        = string
  default     = "Postpaid" # 默认值
}
# 清洗带宽 实例提供的清洗带宽
variable "normal_bandwidth" {
  description = "Clean bandwidth provided by the instance, valid only when product_type is ddosDip"
  type        = number
  default     = 100
}
# 每秒查询数 实例提供的清洗QPS
variable "normal_qps" {
  description = "Normal QPS provided by the instance, valid only for security_acceleration"
  type        = number
  default     = 500
}
# 功能版本 标准功能计划
variable "function_version" {
  description = "Function version of the instance, valid only for security_acceleration"
  type        = number
  default     = 0
}

provider "alicloud" {
  region = var.region_id
}

resource "alicloud_ddoscoo_instance" "newInstance" {
  name             = var.ddoscoo_instance_name
  port_count       = var.port_count
  domain_count     = var.domain_count
  period           = var.pricing_mode == "Prepaid" ? var.period : null
  product_type     = var.product_type
  product_plan     = var.product_plan
  function_version = var.function_version
  normal_bandwidth = var.normal_bandwidth

}

output "instance_id" {
  description = "The ID of the DDoS CoO instance"
  value       = alicloud_ddoscoo_instance.newInstance.id
}

output "instance_name" {
  description = "The name of the DDoS CoO instance"
  value       = var.ddoscoo_instance_name
}