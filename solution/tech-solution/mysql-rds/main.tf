data "alicloud_db_zones" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

# 查询实例实例规格
data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_db_zones.default.zones.0.id
  system_disk_category = "cloud_essd"
}

data "alicloud_db_instance_classes" "default" {
  zone_id                  = data.alicloud_db_zones.default.zones.0.id
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "Basic"
  instance_charge_type     = "PostPaid"
  db_instance_storage_type = "cloud_essd"
}


# VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = "database-migration-test"
  cidr_block = "192.168.0.0/16"
}

# VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_db_zones.default.zones.0.id
  vswitch_name = "database-migration-vswitch"
}

# Security Group
resource "alicloud_security_group" "security_group" {
  security_group_name = "SG-DTS-GROUP-20220101"
  vpc_id              = alicloud_vpc.vpc.id
}

# Security Group Rule - Allow all traffic
resource "alicloud_security_group_rule" "security_group_ingress" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "all"
  port_range        = "-1/-1"
  cidr_ip           = "0.0.0.0/0"
}

# Data source for ECS image
data "alicloud_images" "instance_image" {
  name_regex    = "^aliyun_3_x64_20G_alibase_*"
  most_recent   = true
  owners        = "system"
  instance_type = data.alicloud_instance_types.default.instance_types[0].id
}

# ECS Instance (WebServer)
resource "alicloud_instance" "web_server" {
  instance_name              = "database-migration-webserver"
  image_id                   = data.alicloud_images.instance_image.images[0].id
  instance_type              = data.alicloud_instance_types.default.instance_types[0].id
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.vswitch.id
  system_disk_category       = "cloud_essd"
  internet_max_bandwidth_out = 80
  password                   = var.ecs_instance_password
  instance_charge_type       = "PostPaid"
}

# RDS Instance (Database)
resource "alicloud_db_instance" "database" {
  engine               = "MySQL"
  engine_version       = "8.0"
  instance_type        = data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  instance_storage     = 20
  vpc_id               = alicloud_vpc.vpc.id
  vswitch_id           = alicloud_vswitch.vswitch.id
  security_group_ids   = [alicloud_security_group.security_group.id]
  security_ips         = [alicloud_instance.web_server.private_ip]
  zone_id              = data.alicloud_db_zones.default.zones.0.id
  instance_charge_type = "Postpaid"
  category             = "Basic"
}

# RDS Database
resource "alicloud_db_database" "wordpress_db" {
  instance_id   = alicloud_db_instance.database.id
  name          = "wordpressdb"
  character_set = "utf8mb4"
  description   = "WordPress database for migration test"
}

# RDS Account
resource "alicloud_rds_account" "db_user" {
  db_instance_id      = alicloud_db_instance.database.id
  account_name        = var.db_user_name
  account_password    = var.db_password
  account_type        = "Super"
  account_description = "Database user for WordPress"
}

# Local script for WordPress installation
locals {
  wordpress_install_script = <<-SHELL
#!/bin/sh
DatabaseUser='wordpressuser'
DatabasePwd='password'
DatabaseName='wordpressdb'
DatabaseHost='localhost'
yum update -y
yum install -y unzip zip
yum install -y mysql-server
systemctl start mysqld
systemctl enable mysqld
mysql -e "CREATE DATABASE wordpressdb;"
mysql -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON wordpressdb.* TO 'wordpressuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "CREATE USER dtssync1 IDENTIFIED BY 'P@ssw0rd';"
mysql -e "GRANT ALL ON *.* TO 'dtssync1'@'%';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "SET GLOBAL binlog_format = 'ROW';"
yum install -y nginx
systemctl start nginx
systemctl enable nginx
yum install -y php php-fpm php-mysqlnd
systemctl start php-fpm
systemctl enable php-fpm
cd /usr/share/nginx/html
wget https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20240726/hhvpuw/wordpress-6.6.1.tar
tar -xvf wordpress-6.6.1.tar
cp -R wordpress/* .
rm -R wordpress
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$DatabaseName/" wp-config.php
sed -i "s/username_here/$DatabaseUser/" wp-config.php
sed -i "s/password_here/$DatabasePwd/" wp-config.php
sed -i "s/localhost/$DatabaseHost/" wp-config.php
systemctl restart nginx
systemctl restart php-fpm
SHELL
}

# ECS Command for WordPress installation
resource "alicloud_ecs_command" "wordpress_install_command" {
  name             = "wordpress-install-command"
  description      = "Install WordPress and MySQL on ECS instance"
  enable_parameter = false
  type             = "RunShellScript"
  command_content  = base64encode(local.wordpress_install_script)
  timeout          = 3600
  working_dir      = "/root"
}

# Execute command on ECS instance
resource "alicloud_ecs_invocation" "wordpress_install_invocation" {
  instance_id = [alicloud_instance.web_server.id]
  command_id  = alicloud_ecs_command.wordpress_install_command.id

  depends_on = [
    alicloud_security_group_rule.security_group_ingress
  ]

  timeouts {
    create = "60m"
  }
}