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
  default = "centos_7_9_x64_20G_alibase_20240628.vhd"
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
  timeout         = 3600
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "invocation" {
  instance_id = [local.instanceId]
  command_id  = alicloud_ecs_command.command.id
  timeouts {
    create = "10m"
  }
}

data "alicloud_instances" "default" {
  count = var.create_instance ? 0 : 1
  ids   = [var.instance_id]
}

locals {
  instanceId         = var.create_instance ? alicloud_instance.instance[0].id : var.instance_id
  instance_public_ip = var.create_instance ? element(alicloud_instance.instance.*.public_ip, 0) : lookup(data.alicloud_instances.default[0].instances.0, "public_ip")
  command_content    = <<SHELL

      #!/bin/bash

      # 更新系统并安装必要的软件包
      yum -y update
      yum -y install epel-release
      yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm  # 对于 CentOS 7
      # yum -y install http://rpms.remirepo.net/enterprise/remi-release-8.rpm  # 对于 CentOS 8

      # 安装并启用 PHP 8.0
      yum-config-manager --enable remi-php80
      yum -y install httpd mariadb-server mariadb php php-mysqlnd php-fpm

      # 启动并启用服务
      systemctl start httpd
      systemctl enable httpd
      systemctl start mariadb
      systemctl enable mariadb

      # 配置MariaDB
      # 注意：在生产环境中，强烈建议设置数据库密码并进行安全配置

      # 安全配置（这里跳过设置root密码步骤，仅用于测试环境）
      # mysql_secure_installation  # 通常这一步需要手动交互，这里跳过

      # 使用MySQL命令行工具创建数据库和用户
      echo "CREATE DATABASE wordpress;" | mysql -u root
      echo "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'Test@12345';" | mysql -u root
      echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';" | mysql -u root
      echo "FLUSH PRIVILEGES;" | mysql -u root

      # 下载并解压WordPress
      cd /var/www/html
      curl -O https://wordpress.org/latest.tar.gz
      tar -xzvf latest.tar.gz
      rm latest.tar.gz

      # 设置目录权限
      chown -R apache:apache /var/www/html/wordpress
      chmod -R 755 /var/www/html/wordpress

      # 配置Apache以支持WordPress,此处代码需按如下格式否则会出现格式错误
cat << 'EOF' > /etc/httpd/conf.d/wordpress.conf
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot "/var/www/html/wordpress"
    ServerName your_domain_or_IP
    ErrorLog "/var/log/httpd/wordpress-error.log"
    CustomLog "/var/log/httpd/wordpress-access.log" combined

    <Directory "/var/www/html/wordpress">
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

      # 重启Apache服务
      systemctl restart httpd

      echo "WordPress installation complete. Please complete the web-based setup by navigating to your server's IP or domain."

  SHELL
}

output "ecs_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.region}&instanceId=${local.instanceId}"
}
