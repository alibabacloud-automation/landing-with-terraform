provider "alicloud" {
  region = var.region_id
}

# 定义区域变量，默认值为 cn-hangzhou
variable "region_id" {
  type    = string
  default = "cn-hangzhou"
}

# 定义命名空间描述变量，默认值为 "a namespace sample"
variable "namespace_description" {
  description = "Namespace Description"
  default     = "a namespace sample"
}

# 定义命名空间名称变量，默认值为 "admin"
variable "namespace_name" {
  description = "Namespace Name"
  type        = string
  default     = "admin"
}

# 定义命名空间ID变量，默认值为 "cn-hangzhou:admin"
variable "namespace_id" {
  description = "Namespace ID"
  type        = string
  default     = "cn-hangzhou:admin"
}

resource "alicloud_sae_namespace" "default" {
  namespace_description = var.namespace_description
  namespace_id          = var.namespace_id
  namespace_name        = var.namespace_name
}

output "namespace_id" {
  value       = alicloud_sae_namespace.default.namespace_id
  description = "The ID of the created namespace."
}