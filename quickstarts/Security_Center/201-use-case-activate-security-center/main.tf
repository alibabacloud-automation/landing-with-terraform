# 配置阿里云provider，设置区域为杭州(cn-hangzhou)
provider "alicloud" {
  region = "cn-hangzhou"
}

# 定义资源名称，默认值为"terraform-example"
variable "name" {
  default = "terraform-example"
}

# 版本代码，默认值为"level2"(企业版)
variable "version_code" {
  default = "level2"
}

# 购买的服务器数量，默认值为"30"
variable "buy_number" {
  default = "30"
}

# 支付类型，默认值为"Subscription"(订阅)
variable "payment_type" {
  default = "Subscription"
}

# 预付费周期，默认值为"1"(单位：月)
variable "period" {
  default = "1"
}

# 自动续订状态，默认值为"ManualRenewal"(手动续订)
variable "renewal_status" {
  default = "ManualRenewal"
}

# 日志分析存储容量，默认值为"100"(单位：GB)
variable "sas_sls_storage" {
  default = "100"
}

# 反勒索软件容量，默认值为"100"(单位：GB)
variable "sas_anti_ransomware" {
  default = "100"
}

# 容器镜像安全扫描次数，默认值为"30"
variable "container_image_scan" {
  default = "30"
}

# 网页防篡改开关，默认值为"1"(是)
variable "sas_webguard_boolean" {
  default = "1"
}

# 防篡改授权数量，默认值为"100"
variable "sas_webguard_order_num" {
  default = "100"
}

# 云蜜罐开关，默认值为"1"(是)
variable "honeypot_switch" {
  default = "1"
}

# 云蜜罐许可证数量，默认值为"32"
variable "honeypot" {
  default = "32"
}

# 恶意文件检测SDK开关，默认值为"1"(是)
variable "sas_sdk_switch" {
  default = "1"
}

# 恶意文件检测数量，默认值为"1000"(单位：10,000次)
variable "sas_sdk" {
  default = "1000"
}
# 容器镜像安全扫描注意：步长为20，即只能填写20的倍数
variable "container_image_scan_new" {
  default = "100"
}

# 使用变量定义的安全威胁检测实例资源
resource "alicloud_threat_detection_instance" "default" {
  version_code             = var.version_code
  buy_number               = var.buy_number
  payment_type             = var.payment_type
  period                   = var.period
  renewal_status           = var.renewal_status
  sas_sls_storage          = var.sas_sls_storage
  sas_anti_ransomware      = var.sas_anti_ransomware
  container_image_scan_new = var.container_image_scan_new
  sas_webguard_boolean     = var.sas_webguard_boolean
  sas_webguard_order_num   = var.sas_webguard_order_num
  honeypot_switch          = var.honeypot_switch
  honeypot                 = var.honeypot
  sas_sdk_switch           = var.sas_sdk_switch
  sas_sdk                  = var.sas_sdk
}