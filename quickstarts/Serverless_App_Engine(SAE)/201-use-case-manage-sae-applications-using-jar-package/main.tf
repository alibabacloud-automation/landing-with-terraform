provider "alicloud" {
  region = var.region_id
}

# 区域ID
variable "region_id" {
  type    = string
  default = "cn-shenzhen"
}

# 应用名称
variable "app_name" {
  description = "The name of the application"
  type        = string
  default     = "manual-jar-tf"
}

# 应用描述
variable "app_description" {
  default     = "description created by Terraform"
  description = "The description of the application"
  type        = string
}

# 应用部署方式
variable "package_type" {
  default     = "FatJar"
  description = "The package type of the application"
  type        = string
}

# 实例CPU规格
variable "cpu" {
  default     = "500"
  description = "The cpu of the application, in unit of millicore"
  type        = string
}

# 实例内存规格
variable "memory" {
  default     = "1024"
  description = "The memory of the application, in unit of MB"
  type        = string
}

# JAR包地址
variable "jar_url" {
  description = "The JAR url of the application, like `oss://my-bucket/my-app.jar`"
  type        = string
  default     = "https://edas-sz.oss-cn-shenzhen.aliyuncs.com/prod/demo/SPRING_CLOUD_CONSUMER.jar"
}

# 应用实例数
variable "replicas" {
  default     = "1"
  description = "The replicas of the application"
  type        = string
}

# 命名空间名称
variable "namespace_name" {
  description = "Namespace Name"
  type        = string
  default     = "tfjardemo"
}

# 命名空间ID
variable "namespace_id" {
  description = "Namespace ID"
  type        = string
  default     = "cn-shenzhen:tfjardemo" # 引用现有的命名空间ID
}

# 命名空间描述
variable "namespace_description" {
  description = "Namespace Description"
  default     = "a namespace"
}

# VPC和安全组
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

# 端口范围
variable "port_range" {
  default     = "1/65535"
  description = "The port range of the security group rule"
  type        = string
}

# CIDR地址
variable "cidr_ip" {
  description = "cidr blocks used to create a new security group rule"
  type        = string
  default     = "0.0.0.0/0"
}

# 地域内可用区
variable "zone_id" {
  description = "Availability Zone ID"
  type        = string
  default     = "cn-shenzhen-e" # 选择一个资源充足的可用区
}

# 应用日志采集到SLS
variable "slsConfig" {
  default     = "[{\"logDir\":\"\",\"logType\":\"stdout\"},{\"logDir\":\"/home/admin/logs/*.log\"}]"
  description = "The config of sls log collect"
  type        = string
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "tf-vpc"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "172.16.1.0/24"
  zone_id      = var.zone_id
  vswitch_name = "tf-vswitch"
  description  = "tf-vswitch description"
}

resource "alicloud_sae_namespace" "default" {
  namespace_id          = var.namespace_id
  namespace_name        = var.namespace_name
  namespace_description = var.namespace_description
}

output "namespace_id" {
  value       = var.namespace_id
  description = "Namespace ID"
}

resource "alicloud_security_group" "sg" {
  name        = var.name
  description = var.description
  vpc_id      = alicloud_vpc.vpc.id
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

resource "alicloud_sae_application" "manual" {
  app_name           = var.app_name
  app_description    = var.app_description
  deploy             = true
  package_url        = var.jar_url
  namespace_id       = alicloud_sae_namespace.default.id
  vswitch_id         = alicloud_vswitch.vswitch.id
  vpc_id             = alicloud_vpc.vpc.id
  security_group_id  = alicloud_security_group.sg.id
  package_type       = var.package_type
  jdk                = "Open JDK 8"
  timezone           = "Asia/Beijing"
  replicas           = var.replicas
  cpu                = var.cpu
  memory             = var.memory
  micro_registration = "0"

  lifecycle {
    ignore_changes = [
      micro_registration
    ]
  }
}

output "app_id" {
  description = "The id of the application"
  value       = alicloud_sae_application.manual.id
}

output "app_name" {
  description = "The name of the application"
  value       = var.app_name
}