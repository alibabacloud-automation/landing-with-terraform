//实例名称
variable "name" {
  default = "terraform-example"
}

// 实例规格
variable "instance_type" {
  default = "ecs.e-c1m2.xlarge"
}

//实例登录密码
variable "instance_password" {
  default = "Test@12345"
}

// 地域
variable "region" {
  default = "cn-beijing"
}

provider "alicloud" {
  region = var.region
}

variable "create_instance" {
  default = true
}

//实例ID
variable "instance_id" {
  default = ""
}

// 镜像ID
variable "image_id" {
  default = "debian_12_8_x64_20G_alibase_20241216.vhd"
}

// 创建VPC
resource "alicloud_vpc" "vpc" {
  count      = var.create_instance ? 1 : 0
  cidr_block = "192.168.0.0/16"
}

// 创建交换机
resource "alicloud_vswitch" "vswitch" {
  count        = var.create_instance ? 1 : 0
  vpc_id       = alicloud_vpc.vpc[0].id
  cidr_block   = "192.168.0.0/16"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = var.name
}

//创建安全组
resource "alicloud_security_group" "group" {
  count               = var.create_instance ? 1 : 0
  security_group_name = var.name
  description         = "foo"
  vpc_id              = alicloud_vpc.vpc[0].id
}

//创建安全组规则（此处仅作示例参考，请您按照自身安全策略设置）
resource "alicloud_security_group_rule" "allow_all_tcp" {
  count             = var.create_instance ? 1 : 0
  type              = "ingress"                           # 规则类型：入站
  ip_protocol       = "tcp"                               # 协议类型：TCP
  policy            = "accept"                            # 策略：接受
  port_range        = "22/22"                             # 端口范围：仅22端口
  priority          = 1                                   # 优先级：1
  security_group_id = alicloud_security_group.group[0].id # 关联到之前创建的安全组
  cidr_ip           = "0.0.0.0/0"                         # 允许所有IP地址访问
}

resource "alicloud_security_group_rule" "allow_tcp_80" {
  count             = var.create_instance ? 1 : 0
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.group[0].id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_tcp_443" {
  count             = var.create_instance ? 1 : 0
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "443/443"
  priority          = 1
  security_group_id = alicloud_security_group.group[0].id
  cidr_ip           = "0.0.0.0/0"
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

//创建实例
resource "alicloud_instance" "instance" {
  count             = var.create_instance ? 1 : 0
  availability_zone = data.alicloud_zones.default.zones.0.id
  security_groups   = alicloud_security_group.group.*.id
  # series III
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  system_disk_name           = var.name
  system_disk_description    = "test_foo_system_disk_description"
  image_id                   = var.image_id
  instance_name              = var.name
  vswitch_id                 = alicloud_vswitch.vswitch.0.id
  internet_max_bandwidth_out = 10
  password                   = var.instance_password
}

resource "alicloud_ecs_command" "install_content" {
  name            = "install_content"
  type            = "RunShellScript"
  command_content = base64encode(local.install_content)
  timeout         = 3600
  working_dir     = "/root"
  depends_on      = [alicloud_instance.instance]
}

resource "alicloud_ecs_invocation" "invocation_install" {
  instance_id = [local.instanceId]
  command_id  = alicloud_ecs_command.install_content.id
  timeouts {
    create = "15m"
  }
}

data "alicloud_instances" "default" {
  count = var.create_instance ? 0 : 1
  ids   = [var.instance_id]
}

locals {
  instanceId         = var.create_instance ? alicloud_instance.instance[0].id : var.instance_id
  instance_public_ip = var.create_instance ? element(alicloud_instance.instance.*.public_ip, 0) : lookup(data.alicloud_instances.default[0].instances.0, "public_ip")
  install_content    = <<SHELL
echo '#!/bin/bash
# 检测操作系统版本
if [ -f /etc/os-release ]; then
    source /etc/os-release || { echo "无法读取 /etc/os-release 文件"; exit 1; }
    if [ -z "$${ID:-}" ] || [ -z "$${VERSION_ID:-}" ]; then
        echo "/etc/os-release 文件格式不符合预期或缺少必要信息"
        exit 1
    fi
    OS=$ID
    VER=$VERSION_ID
    echo "操作系统: $OS 版本: $VER"
else
    echo "无法检测操作系统版本，/etc/os-release 文件不存在"
    exit 1
fi
if [[ $OS == "alinux" ]]; then
url="https://download.bt.cn/install/install_lts.sh"
if [ -f /usr/bin/curl ]; then
    curl -sSO "$url"
else
    wget -O install_lts.sh "$url"
fi
yes | bash install_lts.sh ed8484bec

elif [[ $OS == "centos" ]]; then
url="https://download.bt.cn/install/install_lts.sh"
if [ -f /usr/bin/curl ]; then
    curl -sSO "$url"
else
    wget -O install_lts.sh "$url"
fi
yes | bash install_lts.sh ed8484bec
elif [[ $OS == "ubuntu" ]]; then
wget -O install.sh https://download.bt.cn/install/install_lts.sh && yes | sudo bash install.sh ed8484bec
elif [[ $OS == "debian" ]]; then
wget -O install.sh https://download.bt.cn/install/install_lts.sh && yes | bash install.sh ed8484bec
else
    echo "不支持的操作系统"
    exit 1
fi
' > install.sh
chmod +x install.sh
timeout 300s ./install.sh
bt default > credentials.txt
SHELL
}

output "credentials_info" {
  value = "宝塔面板登录信息请您登录ECS实例后，查看用户主目录下的credentials.txt文件"
}

output "ecs_login_address" {
  value = "ECS远程连接地址：https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.region}&instanceId=${local.instanceId}"
}

output "instance_public_ip" {
  value = local.instance_public_ip
}
