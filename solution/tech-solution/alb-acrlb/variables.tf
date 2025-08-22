variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "region1" {
  type    = string
  default = "cn-chengdu"
}

variable "region2" {
  type    = string
  default = "cn-shanghai"
}

variable "region3" {
  type    = string
  default = "cn-qingdao"
}

variable "zone11_id" {
  type    = string
  default = "cn-chengdu-a"
}

variable "zone12_id" {
  type    = string
  default = "cn-chengdu-b"
}

variable "zone21_id" {
  type    = string
  default = "cn-shanghai-e"
}

variable "zone22_id" {
  type    = string
  default = "cn-shanghai-f"
}

variable "zone31_id" {
  type    = string
  default = "cn-qingdao-c"
}

variable "zone32_id" {
  type    = string
  default = "cn-qingdao-b"
}

variable "vpc1_cidr" {
  type    = string
  default = "172.16.0.0/16"
}

variable "vsw11_cidr" {
  type    = string
  default = "172.16.20.0/24"
}

variable "vsw12_cidr" {
  type    = string
  default = "172.16.21.0/24"
}

variable "vpc2_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vsw21_cidr" {
  type    = string
  default = "10.0.20.0/24"
}

variable "vsw22_cidr" {
  type    = string
  default = "10.0.21.0/24"
}

variable "vpc3_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

variable "vsw31_cidr" {
  type    = string
  default = "192.168.20.0/24"
}

variable "vsw32_cidr" {
  type    = string
  default = "192.168.21.0/24"
}

variable "system_disk_category" {
  type    = string
  default = "cloud_essd"
}

variable "ecs_password" {
  type        = string
  description = "Password for ECS instances"
  sensitive   = true
  default     = "Test12345!"
}

variable "alb_chengdu_back_to_source_routing_cidr1" {
  type    = string
  default = "100.117.130.0/25"
}

variable "alb_chengdu_back_to_source_routing_cidr2" {
  type    = string
  default = "100.117.130.128/25"
}

variable "alb_chengdu_back_to_source_routing_cidr3" {
  type    = string
  default = "100.117.131.0/25"
}

variable "alb_chengdu_back_to_source_routing_cidr4" {
  type    = string
  default = "100.117.131.128/25"
}

variable "alb_chengdu_back_to_source_routing_cidr5" {
  type    = string
  default = "100.122.175.64/26"
}

variable "alb_chengdu_back_to_source_routing_cidr6" {
  type    = string
  default = "100.122.175.128/26"
}

variable "alb_chengdu_back_to_source_routing_cidr7" {
  type    = string
  default = "100.122.175.192/26"
}

variable "alb_chengdu_back_to_source_routing_cidr8" {
  type    = string
  default = "100.122.176.0/26"
}