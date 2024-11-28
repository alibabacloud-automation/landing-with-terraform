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
  default     = "app-slb"
}

variable "image_url" {
  description = "镜像地址"
  type        = string
  default     = "registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-slim:0.9"
}

variable "namespace_id" {
  description = "命名空间ID"
  type        = string
  default     = "cn-shenzhen:demo"
}

variable "namespace_name" {
  description = "命名空间名称"
  type        = string
  default     = "demo"
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
  cidr_block = "10.4.0.0/16"
}

# VSwitch
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
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
resource "alicloud_sae_application" "manual" {
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

# SLB配置
resource "alicloud_slb_load_balancer" "slb" {
  load_balancer_name = "prod"
  address_type       = "internet"
  load_balancer_spec = "slb.s2.small"
  vswitch_id         = alicloud_vswitch.default.id
}

resource "alicloud_sae_load_balancer_internet" "example" {
  app_id          = alicloud_sae_application.manual.id
  internet_slb_id = alicloud_slb_load_balancer.slb.id
  internet {
    protocol    = "HTTP"
    port        = var.port
    target_port = 80
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
  default     = "cn-shenzhen-a"
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
  value       = var.namespace_id
  description = "Namespace ID"
}

output "app_id" {
  description = "The id of the application"
  value       = alicloud_sae_application.manual.id
}

output "app_name" {
  description = "The name of the application"
  value       = var.app_name
}

output "endpoint" {
  value = format("http://%s:%s", alicloud_slb_load_balancer.slb.address, var.port)
}