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
  default = "aliyun_3_x64_20G_alibase_20241218.vhd"
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

//创建安全组
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
    create = "5m"
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
sudo apt update
sudo apt install -y vsftpd
else
sudo yum install -y vsftpd
fi

sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo netstat -antup | grep ftp

sudo useradd -m -s /bin/bash ftptest
echo "ftptest:Test@12345" | sudo chpasswd
# 可选：将用户添加到 sudo 组（如果需要）
# sudo usermod -aG sudo ftptest
echo "用户 ftptest 已成功创建并设置密码。"

sudo mkdir -p /var/ftp/test
sudo touch /var/ftp/test/testfile.txt
sudo chown -R ftptest:ftptest /var/ftp/test
sudo mv /etc/vsftpd.conf /etc/vsftpd.conf.bak

if cat /etc/issue|grep -i Ubuntu ; then
cat << "VSFTPD" > /etc/vsftpd.conf
listen=YES
anonymous_enable=NO
local_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO
local_root=/var/ftp/test
chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list
pasv_enable=YES
allow_writeable_chroot=YES
pasv_address=${local.instance_public_ip}
pasv_min_port=50000
pasv_max_port=50010

VSFTPD

cat << "EOF" > /etc/vsftpd/chroot_list

EOF
else
cat << "VSFTPD" > /etc/vsftpd/vsftpd.conf
listen=YES
anonymous_enable=NO
local_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO
local_root=/var/ftp/test
chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list
pasv_enable=YES
allow_writeable_chroot=YES
pasv_address=${local.instance_public_ip}
pasv_min_port=50000
pasv_max_port=50010

VSFTPD

cat << "EOF" > /etc/vsftpd.chroot_list

EOF
fi

sudo systemctl restart vsftpd

SHELL
}

output "ecs_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.region}&instanceId=${local.instanceId}"
}