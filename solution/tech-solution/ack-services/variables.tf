variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "common_name" {
  type        = string
  description = "通用名称"
  default     = "microservices-on-ack"
}

variable "managed_kubernetes_cluster_name" {
  type        = string
  description = "ACK托管版集群名称，长度5，前缀k8s-hpa-cluster-，必须包含小写字母"
  default     = "k8s-cluster-example"
}