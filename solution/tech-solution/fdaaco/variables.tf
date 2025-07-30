variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "bucket_name_prefix" {
  type        = string
  description = "存储空间名称前缀，长度为3~63个字符，必须以小写字母或数字开头和结尾，可以包含小写字母、数字和连字符(-)。需要全网唯一性，已经存在的不能在创建。"
  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.bucket_name_prefix))
    error_message = "必须为3-63个字符，以小写字母或数字开头和结尾，可包含小写字母、数字和连字符(-)"
  }
  default = "bucket-example"
}

variable "domain_name" {
  description = "域名（当前阿里云账号下已备案的域名，不包含前缀）"
  type        = string
}

variable "domain_prefix" {
  description = "域名前缀"
  type        = string
}

variable "scope" {
  type        = string
  description = "选择加速区域。加速区域为仅中国内地和全球时，服务域名必须备案。"
  default     = "domestic"
}