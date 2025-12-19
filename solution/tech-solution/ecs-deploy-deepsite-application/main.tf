provider "alicloud" {
  region = "cn-shanghai"
}

resource "random_id" "suffix" {
  byte_length = 8
}

locals {
  common_name = "deepsite-ai-${random_id.suffix.hex}"
}

# VPC资源
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "${local.common_name}-vpc"
}

# 交换机资源
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = var.zone_id
  vswitch_name = "${local.common_name}-vsw"
}

# 安全组资源
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "${local.common_name}-sg"
}

# 安全组入站规则（允许 TCP 8080 端口 - DeepSite 应用访问端口）
resource "alicloud_security_group_rule" "allow_tcp_8080" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "8080/8080"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "192.168.0.0/24"
  # 如需允许从公网访问ECS，请将cidr_ip修改为0.0.0.0/0
  # cidr_ip           = "0.0.0.0/0"
}

# 安全组入站规则（允许 TCP 80 端口 - 可选，用于 Nginx 部署生成的网页）
resource "alicloud_security_group_rule" "allow_tcp_80" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "192.168.0.0/24"
  # 如需允许从公网访问ECS，请将cidr_ip修改为0.0.0.0/0
  # cidr_ip           = "0.0.0.0/0"
}

# 安全组入站规则（允许 TCP 443 端口 - 可选，用于 HTTPS 访问）
resource "alicloud_security_group_rule" "allow_tcp_443" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "443/443"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "192.168.0.0/24"
  # 如需允许从公网访问ECS，请将cidr_ip修改为0.0.0.0/0
  # cidr_ip           = "0.0.0.0/0"
}

# ECS实例资源
resource "alicloud_instance" "ecs_instance" {
  instance_name              = "${local.common_name}-ecs"
  system_disk_category       = "cloud_essd_entry"
  image_id                   = "aliyun_3_x64_20G_alibase_20251030.vhd"
  vswitch_id                 = alicloud_vswitch.vswitch.id
  password                   = var.ecs_instance_password
  instance_type              = var.instance_type
  internet_max_bandwidth_out = 5
  security_groups            = [alicloud_security_group.security_group.id]
}

# ECS命令资源 - 安装 DeepSite 应用脚本
resource "alicloud_ecs_command" "install_app" {
  name = "install-deepsite-app"
  command_content = base64encode(<<EOF
#!/bin/bash
# 执行 DeepSite 安装脚本
curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20251217/rilwsn/install.sh|bash
EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
}

# 调用命令资源
resource "alicloud_ecs_invocation" "run_install" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.install_app.id
  timeouts {
    create = "60m"
  }
}

