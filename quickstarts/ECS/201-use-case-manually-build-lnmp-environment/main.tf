variable "region" {
  default = "cn-guangzhou"
}

provider "alicloud" {
  region = var.region
}

variable "instance_type" {
  type    = string
  default = "ecs.c6.large"
}

variable "disk_category" {
  default = "cloud_essd"
}

data "alicloud_zones" "default" {
  available_instance_type     = var.instance_type
  available_resource_creation = "VSwitch"
  available_disk_category     = var.disk_category
}

variable "vpc_cidr_block" {
  default = "172.16.0.0/16"
}

variable "vsw_cidr_block" {
  default = "172.16.0.0/24"
}

variable "password" {
  default = "Terraform@Example123!"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc-test-${random_integer.default.result}"
  cidr_block = var.vpc_cidr_block
}

resource "alicloud_security_group" "group" {
  security_group_name = "test-${random_integer.default.result}"
  vpc_id              = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vsw_cidr_block
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "vswitch-test-${random_integer.default.result}"
}

resource "alicloud_instance" "instance" {
  availability_zone          = data.alicloud_zones.default.zones[0].id
  security_groups            = [alicloud_security_group.group.id]
  instance_type              = var.instance_type
  system_disk_category       = var.disk_category // 使用新的变量
  image_id                   = "centos_8_5_x64_20G_alibase_20220428.vhd"
  instance_name              = "test_ecs_${random_integer.default.result}"
  vswitch_id                 = alicloud_vswitch.vswitch.id
  internet_max_bandwidth_out = 10
  password                   = var.password

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

# 安装 MySQL (MariaDB)
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

# 配置 Nginx 来处理 PHP 请求
sudo rm -f /etc/nginx/conf.d/default.conf
sudo tee /etc/nginx/conf.d/default.conf > /dev/null <<NGINX_CONF
server {
    listen       80;
    server_name  localhost;

    root         /usr/share/nginx/html; # 明确指定根目录
    index        index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ =404; # 如果找不到文件或目录，则返回404错误
    }

    location ~ \\.php\$ {
        include fastcgi_params;
        fastcgi_pass unix:/run/php-fpm/www.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;

        # 确保以下参数也被正确设置
        fastcgi_param PATH_INFO \$fastcgi_path_info;
        fastcgi_param PATH_TRANSLATED \$document_root\$fastcgi_path_info;
        fastcgi_param QUERY_STRING \$query_string;
        fastcgi_param REQUEST_METHOD \$request_method;
        fastcgi_param CONTENT_TYPE \$content_type;
        fastcgi_param CONTENT_LENGTH \$content_length;
        fastcgi_param SCRIPT_NAME \$fastcgi_script_name;
        fastcgi_param REQUEST_URI \$request_uri;
        fastcgi_param DOCUMENT_ROOT \$document_root;
        fastcgi_param SERVER_PROTOCOL \$server_protocol;
        fastcgi_param GATEWAY_INTERFACE CGI/1.1;
        fastcgi_param SERVER_SOFTWARE nginx/\$nginx_version;
        fastcgi_param REMOTE_ADDR \$remote_addr;
        fastcgi_param REMOTE_PORT \$remote_port;
        fastcgi_param SERVER_ADDR \$server_addr;
        fastcgi_param SERVER_PORT \$server_port;
        fastcgi_param SERVER_NAME \$server_name;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
NGINX_CONF

sudo systemctl restart nginx

# 创建一个简单的 PHP 测试文件
sudo tee /usr/share/nginx/html/test.php > /dev/null <<PHP_CODE
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
    echo "fail: " . \$e->getMessage();
}

// 关闭连接
\$conn = null;
?>
PHP_CODE

# 确保文件权限正确
sudo chmod 644 /usr/share/nginx/html/test.php

# 测试 PHP 和 MySQL 连接
curl http://127.0.0.1/test.php
EOF
  )
}

output "nginx_test_url" {
  value = "http://${alicloud_instance.instance.public_ip}/test.php"
}