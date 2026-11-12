
locals {
  zone_id = data.alicloud_kvstore_zones.default.ids[length(data.alicloud_kvstore_zones.default.ids) - 1]
}

data "alicloud_kvstore_zones" "default" {
  instance_charge_type = "PostPaid"
  engine               = "Redis"
  product_type         = "OnECS"
}

data "alicloud_db_instance_classes" "default" {
  zone_id                  = local.zone_id
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "PostPaid"
}

# Declare the data source
data "alicloud_instance_types" "default" {
  availability_zone    = local.zone_id
  instance_type_family = "ecs.c7"
}

resource "random_id" "suffix" {
  byte_length = 4
}
locals {
  common_name = "cache-${random_id.suffix.hex}"
}
# VPC 网络资源
resource "alicloud_vpc" "vpc" {
  vpc_name   = "${local.common_name}-vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = local.zone_id
  vswitch_name = "${local.common_name}-vsw"
}

# 安全组
resource "alicloud_security_group" "security_group" {
  security_group_name = "${local.common_name}-sg"
  vpc_id              = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "security_group_rule_ssh" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "22/22"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "security_group_rule_http" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "security_group_rule_https" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "security_group_rule_mysql" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "3306/3306"
  cidr_ip           = "0.0.0.0/0"
}

# 镜像数据源
data "alicloud_images" "ecs_image" {
  name_regex    = "^aliyun_3_x64_20G_alibase_.*"
  most_recent   = true
  owners        = "system"
  instance_type = data.alicloud_instance_types.default.instance_types[0].id
}

# ECS 实例
resource "alicloud_instance" "ecs_instance" {
  instance_name              = "${local.common_name}-ecs"
  image_id                   = data.alicloud_images.ecs_image.images[0].id
  instance_type              = data.alicloud_instance_types.default.instance_types[0].id
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.vswitch.id
  system_disk_category       = "cloud_essd"
  internet_max_bandwidth_out = 5
  password                   = var.ecs_instance_password
}

# RDS 数据库实例
resource "alicloud_db_instance" "rds_instance" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_type            = data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  instance_storage         = data.alicloud_db_instance_classes.default.instance_classes.0.storage_range.min
  db_instance_storage_type = "cloud_essd"
  category                 = "Basic"
  vpc_id                   = alicloud_vpc.vpc.id
  vswitch_id               = alicloud_vswitch.vswitch.id
  security_group_ids       = [alicloud_security_group.security_group.id]
  security_ips             = ["192.168.0.0/24"]
  zone_id                  = local.zone_id
  zone_id_slave_a          = "Auto"
}

# RDS 账户
resource "alicloud_rds_account" "rds_account" {
  db_instance_id   = alicloud_db_instance.rds_instance.id
  account_name     = var.db_user_name
  account_password = var.db_password
  account_type     = "Super"
}

# RDS 数据库
resource "alicloud_db_database" "rds_database" {
  instance_id   = alicloud_db_instance.rds_instance.id
  name          = "biz"
  character_set = "utf8mb4"
  depends_on    = [alicloud_rds_account.rds_account]
}

# Redis 实例
resource "alicloud_kvstore_instance" "redis_instance" {
  db_instance_name = "${local.common_name}-redis"
  instance_class   = "redis.shard.small.2.ce"
  instance_type    = "Redis"
  engine_version   = "6.0"
  vswitch_id       = alicloud_vswitch.vswitch.id
  zone_id          = local.zone_id
  password         = var.redis_password
  security_ips     = ["192.168.0.0/24"]
}

# Redis 账户
resource "alicloud_kvstore_account" "redis_account" {
  instance_id       = alicloud_kvstore_instance.redis_instance.id
  account_name      = var.redis_account_name
  account_password  = var.redis_password
  account_privilege = "RoleReadWrite"
  account_type      = "Normal"
}


# 本地变量 - 安装脚本
locals {
  install_script = <<-SHELL
#!/bin/bash

# 环境变量配置
export PATH=/usr/local/bin:$PATH

function log_info() {
    printf "%s [INFO] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
}

function log_error() {
    printf "%s [ERROR] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
}

function log_fatal() {
    printf "\n========================================================================\n"
    printf "%s [FATAL] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$2"
    printf "\n========================================================================\n"
    exit $1
}

function debug_exec(){
    local cmd="$@"
    log_info "$cmd"
    eval "$cmd"
    ret=$?
    echo ""
    log_info "$cmd, exit code: $ret"
    return $ret
}

function install_web() {
    yum install nginx -y
    yum install java-1.8.0-openjdk.x86_64 -y
    sed -i 's/ _;/ domain.not.exists;/' /etc/nginx/nginx.conf
    curl -o AppWithRedisDemo.jar 'https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/demos/AppWithRedisDemo.jar'
}

if ! debug_exec install_web; then
    log_fatal 3 "install web failed"
fi

cat << 'EOF' > /etc/nginx/conf.d/app_with_redis.conf
server {
    listen 80 default_server;
    server_name _;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

EOF

nohup java -DMYSQL_HOST="${alicloud_db_instance.rds_instance.connection_string}" -DMYSQL_PASSWORD="${var.db_password}" -DREDIS_HOST="${alicloud_kvstore_instance.redis_instance.connection_domain}" -DREDIS_PASSWORD="redis:${var.redis_password}" -DAPP_MANUAL_DEPLOY="false" -jar AppWithRedisDemo.jar  > output.log 2>&1 &
/bin/systemctl start nginx.service
SHELL
}

# ECS 命令
resource "alicloud_ecs_command" "install_web_command" {
  name             = "install-web-command"
  description      = "Install web application with Redis demo"
  enable_parameter = false
  type             = "RunShellScript"
  command_content  = base64encode(local.install_script)
  timeout          = 3600
  working_dir      = "/root"
}

# 在ECS中执行命令
resource "alicloud_ecs_invocation" "install_web_invocation" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.install_web_command.id

  depends_on = [
    alicloud_db_database.rds_database,
    alicloud_kvstore_account.redis_account
  ]

  timeouts {
    create = "10m"
  }
}