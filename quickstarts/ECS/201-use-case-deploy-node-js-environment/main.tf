//实例名称
variable "name" {
  default = "terraform-example"
}

// 实例规格
variable "instance_type" {
  default = "ecs.e-c1m2.large"
}

//实例登录密码
variable "instance_password" {
  default = "Test@12345"
}

// 地域
variable "region" {
  default = "cn-heyuan"
}

provider "alicloud" {
  region = var.region
}

// 如果要在现有实例上安装node.js，请将create_instance设置为false，并将instance_id设置为实例id。
variable "create_instance" {
  default = true
}

//实例ID
variable "instance_id" {
  default = ""
}

// 镜像ID
variable "image_id" {
  default = "aliyun_3_x64_20G_alibase_20240528.vhd"
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

resource "alicloud_security_group_rule" "allow_icmp_all" {
  count             = var.create_instance ? 1 : 0
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
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

resource "alicloud_ecs_command" "command" {
  name            = "DeploydNodejs"
  type            = "RunShellScript"
  command_content = base64encode(local.command_content)
  timeout         = 300
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "invocation" {
  instance_id = [local.instanceId]
  command_id  = alicloud_ecs_command.command.id
  timeouts {
    create = "5m"
  }
}

data "alicloud_instances" "default" {
  count = var.create_instance ? 0 : 1
  ids   = [var.instance_id]
}

locals {
  instanceId         = var.create_instance ? alicloud_instance.instance[0].id : var.instance_id
  instance_public_ip = var.create_instance ? element(alicloud_instance.instance.*.public_ip, 0) : lookup(data.alicloud_instances.default[0].instances.0, "public_ip")
  command_content    = <<EOF
    #!/bin/bash

    if cat /etc/issue|grep -i Ubuntu ; then
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y curl gnupg2 software-properties-common
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt install -y nodejs

    elif cat /etc/issue|grep -i Debian ; then
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y curl gnupg2 software-properties-common
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt install -y nodejs

    else
    sudo yum install git -y
    git clone https://gitee.com/mirrors/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
    sudo sh -c 'echo ". ~/.nvm/nvm.sh" >> /etc/profile'
    source /etc/profile
    export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node
    nvm install v23.3.0
    fi

  EOF
}

output "instance_public_ip" {
  value = local.instance_public_ip
}

