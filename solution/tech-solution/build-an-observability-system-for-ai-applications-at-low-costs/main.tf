# ------------------------------------------------------------------------------
# 核心资源定义 (Main Resource Definitions)
#
# 本文件包含了模块的核心基础设施资源。
# 这里的代码负责根据输入变量来创建和配置所有云资源。
# ------------------------------------------------------------------------------

# 配置阿里云提供商 (Provider)
provider "alicloud" {
  region = "cn-shanghai"
}

# 查询当前部署地域
data "alicloud_regions" "current_region_ds" {
  current = true
}

# 查询支持指定ECS实例规格和磁盘类型的可用区
data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.ecs_instance_type
}

# 创建一个随机ID，用于生成唯一的资源名称后缀，避免命名冲突
resource "random_string" "suffix" {
  length  = 8
  lower   = true
  upper   = false
  numeric = false
  special = false
}

# 定义一个局部变量，将随机ID用作通用名称后缀
locals {
  common_name = random_string.suffix.id
  region      = data.alicloud_regions.current_region_ds.regions.0.id
}

# 创建一个专有网络（VPC），为云资源提供一个隔离的网络环境
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "vpc-${local.common_name}"
}

# 创建一个交换机（VSwitch），用于在VPC内划分一个子网
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = "vswitch-${local.common_name}"
}

# 创建一个安全组，作为虚拟防火墙来控制ECS实例的网络访问
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg-${local.common_name}"
}

# 在安全组中添加入方向规则，允许外部流量访问8000端口
resource "alicloud_security_group_rule" "allow" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "8000/8000"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "192.168.0.0/24"
  # 如需允许从公网访问ECS，请将cidr_ip修改为0.0.0.0/0
  # cidr_ip           = "0.0.0.0/0"
}

# 查询可用的阿里云镜像
data "alicloud_images" "default" {
  # name_regex  = "^aliyun_3_x64_20G_alibase_.*"
  name_regex  = "^ubuntu_24_04_x64_20G_alibase_.*"
  most_recent = true
  owners      = "system"
}

# 创建一个RAM用户，用于后续给ECS实例授权访问其他云服务
resource "alicloud_ram_user" "ram_user" {
  name = "ram-user-${local.common_name}"
}

# 为前面创建的RAM用户生成一个Access Key
resource "alicloud_ram_access_key" "ramak" {
  user_name = alicloud_ram_user.ram_user.name
}

# 为RAM用户附加一个系统策略
resource "alicloud_ram_user_policy_attachment" "attach_policy_to_user" {
  user_name = alicloud_ram_user.ram_user.name
  # 策略类型为系统预设策略
  policy_type = "System"
  # 授予日志服务的完全访问权限
  policy_name = "AliyunLogFullAccess"
}

# 创建一台ECS实例（云服务器）
resource "alicloud_instance" "ecs_instance" {
  instance_name              = "ecs-${local.common_name}"
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.ecs_instance_type
  system_disk_category       = "cloud_essd"
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.vswitch.id
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = 5
}

# 创建一个云助手命令，指令用于：部署示例应用，并通过应用接口来调用大模型
resource "alicloud_ecs_command" "run_command" {
  name = "command-run-${local.common_name}"
  command_content = base64encode(<<EOF
#!/bin/bash
export ARMS_APP_NAME=llm_app
export ARMS_REGION_ID=${local.region}
export ARMS_IS_PUBLIC=True
export ARMS_LICENSE_KEY=${var.arms_license_key}
export DASHSCOPE_API_KEY=${var.bai_lian_api_key}

curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/install-script/ai-observable/install.sh | bash # 部署应用

EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
}

# 在指定的ECS实例上执行上面创建的云助手命令
resource "alicloud_ecs_invocation" "invoke_script" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.run_command.id
  timeouts {
    create = "15m"
  }
}
