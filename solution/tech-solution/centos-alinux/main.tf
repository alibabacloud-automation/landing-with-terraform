# 查询实例实例规格
data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7"
  sorted_by            = "CPU"
}

# 查询实例规格支持的可用区
data "alicloud_zones" "default" {
  available_instance_type = data.alicloud_instance_types.default.ids.0
}

# 查询镜像
data "alicloud_images" "default" {
  name_regex    = "^centos_7_8_x64*"
  owners        = "system"
  instance_type = data.alicloud_instance_types.default.ids.0
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "wordpress-vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_zones.default.ids.0
  vswitch_name = "wordpress-vsw"
}

resource "alicloud_security_group" "security_group" {
  security_group_name = "wordpress-sg"
  vpc_id              = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "http_ingress" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "https_ingress" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "ecs_instance" {
  instance_name              = "wordpress-ecs"
  image_id                   = data.alicloud_images.default.ids.0
  instance_type              = data.alicloud_instance_types.default.ids.0
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.vswitch.id
  internet_max_bandwidth_out = 5
  system_disk_category       = "cloud_essd"
  password                   = var.ecs_instance_password
}

// 在 main.tf 中添加 ECS Command 和 Invocation 资源
resource "alicloud_ecs_command" "wordpress_install" {
  name            = "wordpress-install"
  description     = "Install WordPress on CentOS 7"
  type            = "RunShellScript"
  command_content = base64encode(local.install_wordpress_script)
  timeout         = 7200
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "wordpress_install" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.wordpress_install.id
  timeouts {
    create = "5m"
  }
}

locals {
  install_wordpress_script = <<-SHELL
  #!/bin/bash
  if [ ! -f .ros.provision ]; then
    echo "Name: 手动搭建WordPress（CentOS 7）" > .ros.provision
  fi

  name=$(grep "^Name:" .ros.provision | awk -F':' '{print $2}' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
  if [[ "$name" != "手动搭建WordPress（CentOS 7）" ]]; then
    echo "当前实例已使用过\"$name\"教程的一键配置，不能再使用本教程的一键配置"
    exit 0
  fi

  echo "#########################"
  echo "# Check Network"
  echo "#########################"
  ping -c 2 -W 2 aliyun.com > /dev/null
  if [[ $? -ne 0 ]]; then
    echo "当前实例无法访问公网"
    exit 0
  fi

  if ! grep -q "^Step1: Prepare Environment$" .ros.provision; then
    echo "#########################"
    echo "# Prepare Environment"
    echo "#########################"
    systemctl status firewalld
    systemctl stop firewalld
    echo "Step1: Prepare Environment" >> .ros.provision
  else
    echo "#########################"
    echo "# Environment has been ready"
    echo "#########################"
  fi

  if ! grep -q "^Step2: Install Nginx$" .ros.provision; then
    echo "#########################"
    echo "# Install Nginx"
    echo "#########################"
    yum -y install nginx
    nginx -v
    echo "Step2: Install Nginx" >> .ros.provision
  else
    echo "#########################"
    echo "# Nginx has been installed"
    echo "#########################"
  fi

  if ! grep -q "^Step3: Install MySQL$" .ros.provision; then
    echo "#########################"
    echo "# Install MySQL"
    echo "#########################"
    rpm -Uvh  https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
    yum -y install mysql-community-server --nogpgcheck
    mysql -V
    systemctl start mysqld
    systemctl enable mysqld
    systemctl daemon-reload
    echo "Step3: Install MySQL" >> .ros.provision
  else
    echo "#########################"
    echo "# MySQL has been installed"
    echo "#########################"
  fi

  if ! grep -q "^Step4: Install PHP$" .ros.provision; then
    echo "#########################"
    echo "# Install PHP"
    echo "#########################"
    yum install -y \
      https://mirrors.aliyun.com/ius/ius-release-el7.rpm \
      https://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm
    rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
    yum -y install php70w-devel php70w.x86_64 php70w-cli.x86_64 php70w-common.x86_64 php70w-gd.x86_64 php70w-ldap.x86_64 php70w-mbstring.x86_64 php70w-mcrypt.x86_64  php70w-pdo.x86_64   php70w-mysqlnd  php70w-fpm php70w-opcache php70w-pecl-redis php70w-pecl-mongodb
    php -v
    echo "Step4: Install PHP" >> .ros.provision
  else
    echo "#########################"
    echo "# PHP has been installed"
    echo "#########################"
  fi

  if ! grep -q "^Step4: Config Nginx$" .ros.provision; then
    echo "#########################"
    echo "# Config Nginx"
    echo "#########################"
    cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
    cat > /etc/nginx/nginx.conf << \EOF
  # For more information on configuration, see:
  #   * Official English Documentation: http://nginx.org/en/docs/
  #   * Official Russian Documentation: http://nginx.org/ru/docs/

  user nginx;
  worker_processes auto;
  error_log /var/log/nginx/error.log;
  pid /run/nginx.pid;

  # Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
  include /usr/share/nginx/modules/*.conf;

  events {
      worker_connections 1024;
  }

  http {
      log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                        '$status $body_bytes_sent "$http_referer" '
                        '"$http_user_agent" "$http_x_forwarded_for"';

      access_log  /var/log/nginx/access.log  main;

      sendfile            on;
      tcp_nopush          on;
      tcp_nodelay         on;
      keepalive_timeout   65;
      types_hash_max_size 4096;

      include             /etc/nginx/mime.types;
      default_type        application/octet-stream;

      include /etc/nginx/conf.d/*.conf;

      server {
          listen       80;
          listen       [::]:80;
          server_name  _;
          root         /usr/share/nginx/html/wordpress;

          # Load configuration files for the default server block.
          include /etc/nginx/default.d/*.conf;

          location / {
              index index.php index.html index.htm;
          }

          location ~ .php$ {
              root /usr/share/nginx/html/wordpress;    # 将/usr/share/nginx/html替换为您的网站根目录，本文使用/usr/share/nginx/html作为网站根目录。
              fastcgi_pass 127.0.0.1:9000;   # Nginx通过本机的9000端口将PHP请求转发给PHP-FPM进行处理。
              fastcgi_index index.php;
              fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
              include fastcgi_params;   # Nginx调用fastcgi接口处理PHP请求。
          }

          error_page 404 /404.html;
          location = /404.html {
          }

          error_page 500 502 503 504 /50x.html;
          location = /50x.html {
          }
      }

  }
  EOF
    systemctl start nginx
    systemctl enable nginx
    echo "Step4: Config Nginx" >> .ros.provision
  else
    echo "#########################"
    echo "# Nginx has been configured"
    echo "#########################"
  fi

  if ! grep -q "^Step6: Config MySQL$" .ros.provision; then
    echo "#########################"
    echo "# Config MySQL"
    echo "#########################"
    export MYSQL_PWD=`grep "temporary password" /var/log/mysqld.log | awk '{print $NF}'`
    mysqladmin -uroot password '${var.db_password}'
    export MYSQL_PWD='${var.db_password}'
    mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${var.db_password}'"
    echo CREATE DATABASE wordpress\; >> /tmp/setup.mysql
    echo CREATE user "user"@"localhost" identified by '"${var.db_password}"'\; >> /tmp/setup.mysql
    echo GRANT ALL privileges ON wordpress.* TO "user"@"localhost" IDENTIFIED BY '"${var.db_password}"'\; >> /tmp/setup.mysql
    echo FLUSH privileges\;>> /tmp/setup.mysql
    chmod 400 /tmp/setup.mysql
    mysql -u root --password='${var.db_password}' < /tmp/setup.mysql
    echo "Step6: Config MySQL" >> .ros.provision
  else
    echo "#########################"
    echo "# MySQL has been configured"
    echo "#########################"
  fi

  if ! grep -q "^Step7: Config PHP$" .ros.provision; then
    echo "#########################"
    echo "# Config PHP"
    echo "#########################"
    echo "<?php phpinfo(); ?>" > /usr/share/nginx/html/phpinfo.php
    systemctl start php-fpm
    systemctl enable php-fpm
    echo "Step7: Config PHP" >> .ros.provision
  else
    echo "#########################"
    echo "# PHP has been configured"
    echo "#########################"
  fi

  if ! grep -q "^Step8: Install wordpress$" .ros.provision; then
    echo "#########################"
    echo "# Install wordpress"
    echo "#########################"
    yum -y install wordpress
    echo "Step8: Install wordpress" >> .ros.provision
  else
    echo "#########################"
    echo "# wordpress has been installed"
    echo "#########################"
  fi

  if ! grep -q "^Step9: Config wordpress$" .ros.provision; then
    echo "#########################"
    echo "# Config wordpress"
    echo "#########################"
    mv /usr/share/wordpress /usr/share/nginx/html/wordpress
    cd /usr/share/nginx/html/wordpress
    ln -snf /etc/wordpress/wp-config.php wp-config.php
    sed -i "s/database_name_here/wordpress/" wp-config.php
    sed -i "s/username_here/user/" wp-config.php
    sed -i "s/password_here/${var.db_password}/" wp-config.php
    echo "Step8: Config wordpress" >> .ros.provision
  else
    echo "#########################"
    echo "# wordpress has been configured"
    echo "#########################"
  fi

  systemctl restart nginx
  SHELL
}