variable "region1" {
  description = "Region ID"
  type        = string
  default     = "cn-chengdu"
}

variable "region2" {
  description = "Region ID"
  type        = string
  default     = "cn-shanghai"
}

variable "region3" {
  description = "Region ID"
  type        = string
  default     = "cn-qingdao"
}

variable "zone11_id" {
  description = "zone11 ID"
  type        = string
  default     = "cn-chengdu-a"
}

variable "zone12_id" {
  description = "zone12 ID"
  type        = string
  default     = "cn-chengdu-b"
}

variable "zone21_id" {
  description = "zone21 ID"
  type        = string
  default     = "cn-shanghai-e"
}

variable "zone22_id" {
  description = "zone22 ID"
  type        = string
  default     = "cn-shanghai-f"
}

variable "zone31_id" {
  description = "zone31 ID"
  type        = string
  default     = "cn-qingdao-c"
}

variable "zone32_id" {
  description = "zone32 ID"
  type        = string
  default     = "cn-qingdao-b"
}

variable "system_disk_category" {
  description = "System disk category"
  type        = string
  default     = "cloud_essd_entry"
}

variable "ecs_password" {
  description = "ECS instance password"
  type        = string
  sensitive   = true
}