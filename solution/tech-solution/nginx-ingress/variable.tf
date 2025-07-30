variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "ack_name" {
  description = "集群名称：The name must be 1 to 63 characters in length and can contain letters, Chinese characters, digits, and hyphens (-)."
  type        = string
  default     = "cluster-for-nginx-test"
}

variable "common_name" {
  description = "Common Name"
  type        = string
  default     = "ack-for-nginx"
}