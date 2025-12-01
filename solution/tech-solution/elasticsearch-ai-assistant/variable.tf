# ------------------------------------------------------------------------------
# 模块输入变量
#
# 本文件定义了该 Terraform 模块所有可配置的输入变量。
# 每个变量都包含了详细的说明，以帮助用户正确配置模块。
# ------------------------------------------------------------------------------

# Elasticsearch实例的访问密码
variable "elasticsearch_password" {
  type        = string
  sensitive   = true
  description = "elasticsearch_password"
  #default     = ""
  validation {
    condition     = can(regex("^[0-9A-Za-z_!@#$%^&*()_+\\-=\\+]+$", var.elasticsearch_password)) && length(var.elasticsearch_password) >= 8 && length(var.elasticsearch_password) <= 30
    error_message = "长度8-30，必须包含三项（大写字母、小写字母、数字、 !@#$%^&*()_+-=中的特殊符号）"
  }
}

# Elasticsearch实例的公共IP地址
variable "public_ip" {
  type        = string
  description = "Kibana 公网访问白名单 IP，访问 https://ipinfo.io/ip 查看当前公网 IP，或者设置成0.0.0.0/0"
  default     = "0.0.0.0/0"
}