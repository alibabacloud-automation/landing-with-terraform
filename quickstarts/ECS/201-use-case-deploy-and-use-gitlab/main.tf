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

// 地域，国内地域部署会产生超时
variable "region" {
  default = "ap-southeast-1"
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
  default = "aliyun_3_x64_20G_alibase_20241218.vhd"
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

// 创建VPC
resource "alicloud_vpc" "vpc" {
  count      = local.create_instance ? 1 : 0
  cidr_block = "192.168.0.0/16"
}

// 创建交换机
resource "alicloud_vswitch" "vswitch" {
  count        = local.create_instance ? 1 : 0
  vpc_id       = alicloud_vpc.vpc[0].id
  cidr_block   = "192.168.0.0/16"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = var.name
}

// 创建安全组
resource "alicloud_security_group" "group" {
  security_group_name = var.name
  description         = "foo"
  vpc_id              = local.vpc_id
}

//创建安全组规则（此处仅作示例参考，请您按照自身安全策略设置）
resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"                        # 规则类型：入站
  ip_protocol       = "tcp"                            # 协议类型：TCP
  policy            = "accept"                         # 策略：接受
  port_range        = "22/22"                          # 端口范围：仅22端口
  priority          = 1                                # 优先级：1
  security_group_id = alicloud_security_group.group.id # 关联到之前创建的安全组
  cidr_ip           = "0.0.0.0/0"                      # 允许所有IP地址访问
}

resource "alicloud_security_group_rule" "allow_tcp_80" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_tcp_443" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "443/443"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
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
  count = local.create_instance ? 0 : 1
  ids   = [var.instance_id]
}

locals {
  create_instance    = var.instance_id == ""
  instanceId         = local.create_instance ? alicloud_instance.instance[0].id : var.instance_id
  instance_public_ip = local.create_instance ? element(alicloud_instance.instance.*.public_ip, 0) : lookup(data.alicloud_instances.default[0].instances.0, "public_ip")
  vpc_id             = local.create_instance ? alicloud_vpc.vpc[0].id : lookup(data.alicloud_instances.default[0].instances.0, "vpc_id")
  install_content    = <<SHELL
#!/bin/bash
if cat /etc/issue|grep -i Ubuntu ; then
sudo apt-get update
sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
sudo curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt-get update
sudo EXTERNAL_URL=${local.instance_public_ip} apt-get install -y gitlab-ce
else
sudo yum install -y curl python3-policycoreutils openssh-server
curl -fsSL https://get.gitlab.cn | sudo /bin/bash
sudo EXTERNAL_URL=${local.instance_public_ip} yum install -y gitlab-jh
fi
SHELL
}

output "GitLab_url" {
  value = format("GitLab管理页面：http://%s", local.instance_public_ip)
}

output "ecs_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.region}&instanceId=${local.instanceId}"
}
