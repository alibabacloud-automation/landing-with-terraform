// 定义变量 region，用于指定阿里云的区域，默认值为 cn-guangzhou
variable "region" {
  default = "cn-guangzhou"
}

// 定义阿里云 provider，并使用上面定义的 region 变量设置区域
provider "alicloud" {
  region = var.region
}

// 定义变量 instance_type，类型为字符串，指定实例类型，默认值为 ecs.c6.large
variable "instance_type" {
  type    = string
  default = "ecs.c6.large"
}

// 定义变量 disk_category，指定磁盘类型，默认值为 cloud_essd
variable "disk_category" {
  default = "cloud_essd"
}

// 定义数据资源 alicloud_zones，用于查找满足以下条件的阿里云可用区
// 可用的实例类型、资源创建类型和磁盘类别分别使用相应的变量指定
data "alicloud_zones" "default" {
  available_instance_type     = var.instance_type
  available_resource_creation = "VSwitch"
  available_disk_category     = var.disk_category
}

// 定义变量 vpc_cidr_block，指定 VPC 的 CIDR 块，默认值为 172.16.0.0/16
variable "vpc_cidr_block" {
  default = "172.16.0.0/16"
}

// 定义变量 vsw_cidr_block，指定 VSwitch 的 CIDR 块，默认值为 172.16.0.0/24
variable "vsw_cidr_block" {
  default = "172.16.0.0/24"
}

// 定义变量 password，指定实例的密码，默认值为 Terraform@Example123!
variable "password" {
  default = "Terraform@Example123!"
}

// 生成一个 10000 到 99999 之间的随机整数
resource "random_integer" "default" {
  min = 10000
  max = 99999
}

// 创建一个阿里云 VPC 资源，名称包含随机整数结果，使用 vpc_cidr_block 变量指定 CIDR 块
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc-test-${random_integer.default.result}"
  cidr_block = var.vpc_cidr_block
}

// 创建一个阿里云安全组资源，名称包含随机整数结果，关联上面创建的 VPC
resource "alicloud_security_group" "group" {
  name   = "test-${random_integer.default.result}"
  vpc_id = alicloud_vpc.vpc.id
}

// 创建一个安全组规则，允许 TCP 协议的 22 端口的入站流量，优先级为 1，关联上述安全组
resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

// 创建一个安全组规则，允许 TCP 协议的 80 端口的入站流量，优先级为 1，关联上述安全组
resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

// 创建一个阿里云 VSwitch 资源，关联上述 VPC，使用 vsw_cidr_block 变量指定 CIDR 块，使用 alicloud_zones 数据资源的第一个可用区 ID
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vsw_cidr_block
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "vswitch-test-${random_integer.default.result}"
}

// 创建一个阿里云实例资源
resource "alicloud_instance" "instance" {
  // 使用 alicloud_zones 数据资源的第一个可用区 ID
  availability_zone = data.alicloud_zones.default.zones[0].id
  // 关联上述安全组
  security_groups = [alicloud_security_group.group.id]
  // 使用 instance_type 变量指定实例类型
  instance_type = var.instance_type
  // 使用 disk_category 变量指定系统磁盘类别
  system_disk_category = var.disk_category
  // 指定镜像 ID
  image_id = "centos_8_5_x64_20G_alibase_20220428.vhd"
  // 实例名称包含随机整数结果
  instance_name = "test_ecs_${random_integer.default.result}"
  // 关联上述 VSwitch
  vswitch_id = alicloud_vswitch.vswitch.id
  // 出站带宽最大值为 10
  internet_max_bandwidth_out = 10
  // 使用 password 变量设置实例密码
  password = var.password

  // 定义用户数据，以 base64 编码，包含一个 shell 脚本
  user_data = base64encode(<<-EOF
#!/bin/sh

# 更新系统软件包
sudo dnf update -y

# 添加 Nginx 仓库并安装 Nginx
sudo tee /etc/yum.repos.d/nginx.repo > /dev/null <<REPO
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/8/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/8/\$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
REPO

sudo dnf install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# 安装 MariaDB (MySQL)
sudo rpm -Uvh https://repo.mysql.com/mysql84-community-release-el8-1.noarch.rpm
sudo dnf install -y mysql-server
sudo systemctl start mysqld
sudo systemctl enable mysqld

# 设置 MySQL root 用户密码
TEMP_PASS=$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'YourStrong!Pass4word';" | sudo mysql --connect-expired-password

# 创建 test 数据库
echo "CREATE DATABASE IF NOT EXISTS test;" | sudo mysql --user=root --password=YourStrong!Pass4word

# 安装 PHP 及相关模块
sudo rpm -Uvh https://mirrors.aliyun.com/remi/enterprise/remi-release-8.rpm --nodeps
sudo dnf module reset php
sudo dnf module enable php:remi-8.4
sudo dnf install -y php php-fpm php-mysqlnd
sudo systemctl start php-fpm
sudo systemctl enable php-fpm


# 创建一个简单的 PHP 测试文件
sudo tee /etc/nginx/html/test.php > /dev/null <<PHP_CODE
<?php
\$servername = "localhost";
\$username = "root";
\$password = "YourStrong!Pass4word";

try {
    \$conn = new PDO("mysql:host=\$servername;dbname=test", \$username, \$password);
    // 设置 PDO 错误模式为异常
    \$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "success\n";
} catch(PDOException \$e) {
    echo "fail: ". \$e->getMessage();
}

// 关闭连接
\$conn = null;
?>
PHP_CODE

# 确保文件权限正确
sudo chmod 644 /etc/nginx/html/test.php

# 测试 PHP 和 MySQL 连接
curl http://127.0.0.1/test.php

# 创建测试网站文件夹
sudo mkdir -p /usr/share/nginx/html/Testpage-1
sudo mkdir -p /usr/share/nginx/html/Testpage-2

# 配置测试站点 Testpage-1 的信息
sudo tee /usr/share/nginx/html/Testpage-1/index.html > /dev/null <<HTML_CODE
<!DOCTYPE html>
<html>
<head>
<title>Test Page 1</title>
</head>
<body>
<h1>Test page 1</h1>
</body>
</html>
HTML_CODE

# 配置测试站点 Testpage-2 的信息
sudo tee /usr/share/nginx/html/Testpage-2/index.html > /dev/null <<HTML_CODE
<!DOCTYPE html>
<html>
<head>
<title>Test Page 2</title>
</head>
<body>
<h1>Test page 2</h1>
</body>
</html>
HTML_CODE

# 配置 Nginx 来处理 PHP 请求
sudo rm -f /etc/nginx/nginx.conf
sudo tee /etc/nginx/nginx.conf > /dev/null <<NGINX_CONF
user  nginx;
worker_processes  auto;
error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;
events {
    worker_connections  1024;
}
http {
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;
    sendfile        on;
    #tcp_nopush     on;
    keepalive_timeout  65;
    #gzip  on;
    include /etc/nginx/conf.d/*.conf;
}
NGINX_CONF

# 为测试站点创建并配置 Nginx 配置文件
# Testpage1.conf
sudo tee /etc/nginx/conf.d/Testpage1.conf > /dev/null <<NGINX_CONF
server {
    listen       80;
    server_name  testpage1.com;    #此处使用测试域名。实际配置中使用您的服务器域名。

    #charset koi8-r;
    access_log  /var/log/nginx/b.access.log  main;

    location / {
        root   /usr/share/nginx/html;    #测试站点路径。即您的项目代码路径。
        index  index.html index.htm;
    }

    #error_page  404              /404.html;

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
NGINX_CONF

# Testpage2.conf
sudo tee /etc/nginx/conf.d/Testpage2.conf > /dev/null <<NGINX_CONF
server {
    listen       80;
    server_name  testpage2.com;    #此处使用测试域名。实际配置中使用您的服务器域名。

    #charset koi8-r;
    access_log  /var/log/nginx/b.access.log  main;

    location / {
        root   /usr/share/nginx/html;    #测试站点路径。即您的项目代码路径。
        index  index.html index.htm;
    }

    #error_page  404              /404.html;

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
NGINX_CONF

# 重启 Nginx 服务以应用更改
sudo systemctl restart nginx
EOF
  )
}
output "HHM-FOFO" {
  value = "程序执初始化中，请等待两分钟再访问站点内容"
}

// 定义一个输出，输出测试用的 Nginx 网址，使用实例的公网 IP 和测试站点路径
output "nginx_test_url" {
  value = "http://${alicloud_instance.instance.public_ip}/Testpage-1"
}
