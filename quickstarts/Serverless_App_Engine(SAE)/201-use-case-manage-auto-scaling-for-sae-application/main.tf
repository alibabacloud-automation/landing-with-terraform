# 提供商配置
provider "alicloud" {
  region = var.region_id
}

# 变量定义
variable "region_id" {
  type    = string
  default = "cn-shenzhen"
}

variable "app_name" {
  description = "应用名称"
  type        = string
  default     = "app-scaling"
}

variable "image_url" {
  description = "镜像地址"
  type        = string
  default     = "registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-slim:0.9"
}

variable "namespace_name" {
  description = "命名空间名称"
  type        = string
  default     = "demo"
}

variable "namespace_id" {
  description = "命名空间ID"
  type        = string
  default     = "cn-shenzhen:demo"
}

# 命名空间
resource "alicloud_sae_namespace" "default" {
  namespace_description = var.namespace_description
  namespace_id          = var.namespace_id
  namespace_name        = var.namespace_name
}

# VPC
resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.0.0.0/16"
}

# VSwitch
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.0.1.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = var.zone_id
}

# 安全组
resource "alicloud_security_group" "sg" {
  name        = var.name
  description = var.description
  vpc_id      = alicloud_vpc.default.id
}

resource "alicloud_security_group_rule" "sg_rule" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = var.port_range
  priority          = 1
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = var.cidr_ip
}

# 应用配置
resource "alicloud_sae_application" "default" {
  app_name          = var.app_name
  app_description   = var.app_description
  deploy            = true
  image_url         = var.image_url
  namespace_id      = alicloud_sae_namespace.default.id
  vswitch_id        = alicloud_vswitch.default.id
  vpc_id            = alicloud_vpc.default.id
  security_group_id = alicloud_security_group.sg.id
  package_type      = var.package_type
  timezone          = "Asia/Beijing"
  replicas          = var.replicas
  cpu               = var.cpu
  memory            = var.memory
}

# 弹性伸缩策略
resource "alicloud_sae_application_scaling_rule" "metrics" {
  app_id              = alicloud_sae_application.default.id
  scaling_rule_name   = "metric-dev"
  scaling_rule_enable = true
  scaling_rule_type   = "mix"

  scaling_rule_timer {
    begin_date = "2024-11-26"
    end_date   = "2024-11-30"
    period     = "* * *"
    schedules {
      at_time      = "19:45"
      max_replicas = 50
      min_replicas = 10
    }
    schedules {
      at_time      = "20:45"
      max_replicas = 40
      min_replicas = 3
    }
  }

  scaling_rule_metric {
    max_replicas = 40
    min_replicas = 3
    metrics {
      metric_type                       = "CPU"
      metric_target_average_utilization = 1
    }
    scale_up_rules {
      step                         = 10
      disabled                     = false
      stabilization_window_seconds = 0
    }
    scale_down_rules {
      step                         = 10
      disabled                     = false
      stabilization_window_seconds = 10
    }
  }
}

# 其他变量定义
variable "namespace_description" {
  description = "Namespace Description"
  default     = "a namespace"
}

variable "name" {
  default     = "tf"
  description = "The name of the security group rule"
  type        = string
}

variable "description" {
  default     = "The description of the security group rule"
  description = "The description of the security group rule"
  type        = string
}

variable "port_range" {
  default     = "1/65535"
  description = "The port range of the security group rule"
  type        = string
}

variable "cidr_ip" {
  description = "cidr blocks used to create a new security group rule"
  type        = string
  default     = "0.0.0.0/0"
}

variable "zone_id" {
  description = "Availability Zone ID"
  type        = string
  default     = "cn-shenzhen-e"
}

variable "app_description" {
  default     = "description created by Terraform"
  description = "The description of the application"
  type        = string
}

variable "package_type" {
  default     = "Image"
  description = "The package type of the application"
  type        = string
}

variable "cpu" {
  default     = "500"
  description = "The cpu of the application, in unit of millicore"
  type        = string
}

variable "memory" {
  default     = "1024"
  description = "The memory of the application, in unit of MB"
  type        = string
}

variable "replicas" {
  default     = "1"
  description = "The replicas of the application"
  type        = string
}

variable "port" {
  description = "The port of SLB"
  type        = string
  default     = "8000"
}

# 输出
output "namespace_id" {
  value       = alicloud_sae_namespace.default.id
  description = "Namespace ID"
}

output "app_id" {
  description = "The id of the application"
  value       = alicloud_sae_application.default.id
}

output "app_name" {
  description = "The name of the application"
  value       = var.app_name
}
