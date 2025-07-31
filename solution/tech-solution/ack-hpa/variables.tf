variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "common_name" {
  type        = string
  description = "集群名称"
  default     = "k8s-hpa-cluster"
}

variable "sls_project_name" {
  type        = string
  default     = "k8s-hpa-sls-project-example"
  description = "日志项目的名称，长度为3~36个字符。必须以小写英文字母或数字开头和结尾。可包含小写英文字母、数字和短划线（-）"
}

variable "managed_kubernetes_cluster_name" {
  type        = string
  description = "ACK托管版集群名称"
  default     = "k8s-hpa-cluster"
}