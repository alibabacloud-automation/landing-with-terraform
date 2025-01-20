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
  default = "aliyun_3_x64_20G_alibase_20241218.vhd"
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

resource "alicloud_ecs_command" "install_content" {
  name            = "install_content"
  type            = "RunShellScript"
  command_content = base64encode(local.install_content)
  timeout         = 3600
  working_dir     = "/root"
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
#!/bin/bash

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
#alinux
if [[ $VER == "3" ]]; then
sudo dnf update -y && sudo dnf install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo yum install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
ROOT_PASSWORD='Test@123456'
sleep 5
sudo mysql -u root -e "USE mysql; ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD';" || \
{ echo "Failed to alter root user. Attempting to create.";
  sudo mysql -u root -e "CREATE USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"; }
sudo yum install -y php php-mysqlnd php-fpm php-gd php-xml php-mbstring
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
sudo touch /etc/httpd/conf.d/php-fpm.conf
sudo tee /etc/httpd/conf.d/php-fpm.conf > /dev/null <<EOF
<FilesMatch \.php$>
    SetHandler "proxy:unix:/run/php-fpm/www.sock;"
</FilesMatch>
EOF
sudo systemctl restart httpd
sudo touch /var/www/html/test.php
sudo tee /var/www/html/test.php > /dev/null <<EOF
<?php
\$servername = "localhost";
\$username = "root";
\$password = "Test@123456";

\$conn = new mysqli(\$servername, \$username, \$password);

if (\$conn->connect_error) {
die("fail: " . \$conn->connect_error);
}
echo "success\n";
?>
EOF
echo "LAMP环境安装完成！"
#alinux2
else
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd
sudo rpm -Uvh https://repo.mysql.com/mysql84-community-release-el7-1.noarch.rpm
sudo yum install -y mysql-server
sudo systemctl start mysqld
sudo systemctl enable mysqld
TEMP_PASSWORD=$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
if [ -z "$TEMP_PASSWORD" ]; then
  echo "Failed to extract temporary password from log."
  exit 1
fi
NEW_MYSQL_PASSWORD="Test@12345"  # 请替换为你想要设置的新密码
echo "Setting MySQL root password to: $NEW_MYSQL_PASSWORD"
sudo mysqladmin -uroot -p"$TEMP_PASSWORD" password "$NEW_MYSQL_PASSWORD"
sudo rpm -Uvh https://mirrors.aliyun.com/remi/enterprise/remi-release-7.rpm --nodeps
sudo yum install -y yum-utils
sudo yum-config-manager --enable remi-php83
sudo yum install -y php php-fpm php-mysqlnd
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
if ! sudo grep -q 'listen =' /etc/php-fpm.d/www.conf; then
  echo "PHP-FPM listen configuration not found. Please check your PHP-FPM configuration."
  exit 1
fi
sudo touch /etc/httpd/conf.d/php-fpm.conf
sudo tee /etc/httpd/conf.d/php-fpm.conf > /dev/null <<EOF
<FilesMatch \.php$>
    SetHandler "proxy:fcgi://127.0.0.1:9000"
</FilesMatch>
EOF
sudo systemctl restart httpd
sudo touch /var/www/html/test.php
sudo tee /var/www/html/test.php > /dev/null <<EOF
<?php
\$servername = "localhost";
\$username = "root";
\$password = "$${NEW_MYSQL_PASSWORD}";

\$conn = new mysqli(\$servername, \$username, \$password);

if (\$conn->connect_error) {
    die("fail: " . \$conn->connect_error);
}
echo "success\n";
?>
EOF
fi

#centos
elif [[ $OS == "centos" ]]; then
if [[ $VER == "8" ]]; then
sudo dnf update -y && sudo dnf install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo yum install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
ROOT_PASSWORD='Test@123456'
sleep 5
sudo mysql -u root -e "USE mysql; ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD';" || \
{ echo "Failed to alter root user. Attempting to create.";
  sudo mysql -u root -e "CREATE USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"; }
sudo yum install -y php php-mysqlnd php-fpm php-gd php-xml php-mbstring
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
sudo touch /etc/httpd/conf.d/php-fpm.conf
sudo tee /etc/httpd/conf.d/php-fpm.conf > /dev/null <<EOF
<FilesMatch \.php$>
    SetHandler "proxy:unix:/run/php-fpm/www.sock;"
</FilesMatch>
EOF
sudo systemctl restart httpd
sudo touch /var/www/html/test.php
sudo tee /var/www/html/test.php > /dev/null <<EOF
<?php
\$servername = "localhost";
\$username = "root";
\$password = "Test@123456";

\$conn = new mysqli(\$servername, \$username, \$password);

if (\$conn->connect_error) {
die("fail: " . \$conn->connect_error);
}
echo "success\n";
?>
EOF
echo "LAMP环境安装完成！"
#alinux2/centos7/8
else
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd
sudo rpm -Uvh https://repo.mysql.com/mysql84-community-release-el7-1.noarch.rpm
sudo yum install -y mysql-server
sudo systemctl start mysqld
sudo systemctl enable mysqld
TEMP_PASSWORD=$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
if [ -z "$TEMP_PASSWORD" ]; then
  echo "Failed to extract temporary password from log."
  exit 1
fi
NEW_MYSQL_PASSWORD="Test@12345"  # 请替换为你想要设置的新密码
echo "Setting MySQL root password to: $NEW_MYSQL_PASSWORD"
sudo mysqladmin -uroot -p"$TEMP_PASSWORD" password "$NEW_MYSQL_PASSWORD"
sudo rpm -Uvh https://mirrors.aliyun.com/remi/enterprise/remi-release-7.rpm --nodeps
sudo yum install -y yum-utils
sudo yum-config-manager --enable remi-php83
sudo yum install -y php php-fpm php-mysqlnd
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
if ! sudo grep -q 'listen =' /etc/php-fpm.d/www.conf; then
  echo "PHP-FPM listen configuration not found. Please check your PHP-FPM configuration."
  exit 1
fi
sudo touch /etc/httpd/conf.d/php-fpm.conf
sudo tee /etc/httpd/conf.d/php-fpm.conf > /dev/null <<EOF
<FilesMatch \.php$>
    SetHandler "proxy:fcgi://127.0.0.1:9000"
</FilesMatch>
EOF
sudo systemctl restart httpd
sudo touch /var/www/html/test.php
sudo tee /var/www/html/test.php > /dev/null <<EOF
<?php
\$servername = "localhost";
\$username = "root";
\$password = "$${NEW_MYSQL_PASSWORD}";

\$conn = new mysqli(\$servername, \$username, \$password);

if (\$conn->connect_error) {
    die("fail: " . \$conn->connect_error);
}
echo "success\n";
?>
EOF
fi

elif [[ $OS == "ubuntu" ]]; then
sudo apt update -y
sudo apt install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2
MYSQL_ROOT_PASSWORD="NewSecurePassword123"  # 设置你的MySQL root密码
echo "mysql-server mysql-server/root_password password $${MYSQL_ROOT_PASSWORD}" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $${MYSQL_ROOT_PASSWORD}" | sudo debconf-set-selections
sudo apt install -y mysql-server
sudo systemctl start mysql
sudo systemctl enable mysql
sudo apt install -y php php-fpm php-mysql
sudo systemctl start php7.4-fpm  # 根据你的PHP版本调整，可能是php8.0-fpm等
sudo systemctl enable php7.4-fpm
sudo a2enmod proxy_fcgi setenvif
sudo a2enconf php7.4-fpm  # 根据你的PHP版本调整，可能是php8.0-fpm等
sudo touch /var/www/html/test.php
sudo tee /var/www/html/test.php > /dev/null <<EOF
<?php
\$servername = "localhost";
\$username = "root";
\$password = "$${MYSQL_ROOT_PASSWORD}";

\$conn = new mysqli(\$servername, \$username, \$password);

if (\$conn->connect_error) {
    die("fail: " . \$conn->connect_error);
}
echo "success\n";
?>
EOF
sudo systemctl restart apache2
else
echo "不支持的操作系统"
exit 1
fi
SHELL
}

output "test_url" {
  value = "http://${local.instance_public_ip}/test.php"
}

output "ecs_login_address" {
  value = "ECS远程连接地址：https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.region}&instanceId=${local.instanceId}"
} //实例名称
