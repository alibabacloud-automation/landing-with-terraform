provider "alicloud" {
  region = var.region_id
}
resource "random_id" "suffix" {
  byte_length = 8
}

locals {
  common_name = random_id.suffix.id
  ecs_command = <<SHELL
#!/bin/bash
cat << INNER_EOF >> ~/.bash_profile
export DB_NAME=${var.db_name}
export DB_USERNAME=${var.db_user}
export DB_PASSWORD=${var.db_password}
export DB_CONNECTION=${alicloud_db_instance.rds_db_instance.connection_string}
export ROS_DEPLOY=true
INNER_EOF

source ~/.bash_profile

curl -fsSL https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/install-script/develop-your-wechat-mini-program-in-10-minutes/install.sh|bash

## 调整db连接配置
sed -i 's/localhost/${alicloud_db_instance.rds_db_instance.connection_string}/' /var/www/html/wp-config.php
sed -i 's/username_here/${var.db_user}/' /var/www/html/wp-config.php
sed -i 's/password_here/${var.db_password}/' /var/www/html/wp-config.php
sed -i 's/database_name_here/${var.db_name}/' /var/www/html/wp-config.php

cd /var/www/html
sudo cat << INNER_EOF > .htaccess
# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteCond \%\{HTTP:Authorization\} ^(.*)
RewriteRule ^(.*) - [E=HTTP_AUTHORIZATION:%1]
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond \%\{REQUEST_FILENAME\} !-f
RewriteCond \%\{REQUEST_FILENAME\} !-d
RewriteRule . /index.php [L]
</IfModule>
# END WordPress
INNER_EOF
sed -i 's/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf

wget https://downloads.wordpress.org/plugin/jwt-authentication-for-wp-rest-api.zip
yum -y install unzip
unzip jwt-authentication-for-wp-rest-api.zip -d jwt-authentication-for-wp-rest-api
cp -r ./jwt-authentication-for-wp-rest-api/jwt-authentication-for-wp-rest-api /var/www/html/wp-content/plugins
rm -rf jwt-authentication-for-wp-rest-api.zip
rm -rf jwt-authentication-for-wp-rest-api
wget https://gitee.com/qin-yangming/open-tools/raw/master/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

SECRET_KEY=$(openssl rand -base64 32) && sed -i "/Database settings/i define('JWT_AUTH_SECRET_KEY', '$SECRET_KEY');\ndefine('JWT_AUTH_CORS_ENABLE', true);\n" /var/www/html/wp-config.php
sed -i 's/\r$//' /var/www/html/wp-config.php
wp core install --url=${alicloud_instance.ecs_instance.public_ip} --title="Hello World" --admin_user=${var.word_press_user_name} --admin_password=${var.word_press_password} --admin_email=${var.word_press_user_email} --skip-email --allow-root

wp plugin activate jwt-authentication-for-wp-rest-api --allow-root --path=/var/www/html

systemctl restart httpd
SHELL
}

data "alicloud_db_zones" "rds_zones" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_instance_types" "default" {
  system_disk_category = "cloud_essd"
  image_id             = data.alicloud_images.default.images[0].id
  instance_type_family = "ecs.c6"
  availability_zone    = data.alicloud_db_zones.rds_zones.zones[length(data.alicloud_db_zones.rds_zones.zones) - 1].id
}

data "alicloud_images" "default" {
  name_regex  = "^centos_7_9_x64_20G_alibase_*"
  most_recent = true
  owners      = "system"
}

data "alicloud_db_instance_classes" "example" {
  zone_id                  = data.alicloud_db_zones.rds_zones.zones[length(data.alicloud_db_zones.rds_zones.zones) - 1].id
  engine                   = data.alicloud_db_zones.rds_zones.engine
  engine_version           = data.alicloud_db_zones.rds_zones.engine_version
  category                 = data.alicloud_db_zones.rds_zones.category
  db_instance_storage_type = data.alicloud_db_zones.rds_zones.db_instance_storage_type
  instance_charge_type     = data.alicloud_db_zones.rds_zones.instance_charge_type
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc"
  cidr_block = var.vpc_cidr_block
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vswitch_cidr_block
  zone_id      = data.alicloud_db_zones.rds_zones.zones[length(data.alicloud_db_zones.rds_zones.zones) - 1].id
  vswitch_name = "vsw"
}

# Security Group
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg"
  security_group_type = "normal"
}

resource "alicloud_security_group_rule" "http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
  security_group_id = alicloud_security_group.security_group.id
}

resource "alicloud_security_group_rule" "https" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "22/22"
  cidr_ip           = "0.0.0.0/0"
  security_group_id = alicloud_security_group.security_group.id
}

# RDS Resources
resource "alicloud_db_instance" "rds_db_instance" {
  engine                   = data.alicloud_db_instance_classes.example.engine
  engine_version           = data.alicloud_db_instance_classes.example.engine_version
  instance_type            = data.alicloud_db_instance_classes.example.instance_classes[0].instance_class
  instance_storage         = data.alicloud_db_instance_classes.example.instance_classes[0].storage_range.min
  db_instance_storage_type = data.alicloud_db_instance_classes.example.db_instance_storage_type
  vswitch_id               = alicloud_vswitch.vswitch.id
  zone_id                  = data.alicloud_db_zones.rds_zones.zones[length(data.alicloud_db_zones.rds_zones.zones) - 1].id
  security_group_ids       = [alicloud_security_group.security_group.id]
}

resource "alicloud_db_database" "rds_database" {
  instance_id   = alicloud_db_instance.rds_db_instance.id
  name          = var.db_name
  character_set = "utf8mb4"
}

resource "alicloud_db_account" "rds_account" {
  db_instance_id   = alicloud_db_instance.rds_db_instance.id
  account_name     = var.db_user
  account_type     = "Normal"
  account_password = var.db_password
}

resource "alicloud_db_account_privilege" "rds_account_privilege" {
  instance_id  = alicloud_db_instance.rds_db_instance.id
  account_name = alicloud_db_account.rds_account.account_name
  db_names     = [alicloud_db_database.rds_database.name]
  privilege    = "ReadWrite"
}

# ECS Resources
resource "alicloud_instance" "ecs_instance" {
  instance_name              = "ecs-${local.common_name}"
  system_disk_category       = data.alicloud_instance_types.default.system_disk_category
  image_id                   = data.alicloud_images.default.images[0].id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  password                   = var.ecs_instance_password
  instance_type              = data.alicloud_instance_types.default.instance_types[0].id
  internet_max_bandwidth_out = 5
  security_groups            = [alicloud_security_group.security_group.id]
}

resource "alicloud_ecs_command" "run_command" {
  name             = "commond_install"
  description      = "commond_install_description"
  enable_parameter = false
  type             = "RunShellScript"
  command_content  = base64encode(local.ecs_command)
  timeout          = 3600
  working_dir      = "/root"
}

resource "alicloud_ecs_invocation" "run_command" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.run_command.id
  timeouts {
    create = "10m"
  }
}