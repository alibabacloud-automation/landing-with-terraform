data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7"
}

data "alicloud_zones" "default" {
  available_instance_type = data.alicloud_instance_types.default.ids.0
}

data "alicloud_db_zones" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "default" {
  zone_id                  = data.alicloud_db_zones.default.ids.0
  instance_charge_type     = "PostPaid"
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_images" "instance_image" {
  name_regex    = "^aliyun_3_9_x64_20G_*"
  most_recent   = true
  owners        = "system"
  instance_type = data.alicloud_instance_types.default.ids.0
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "${var.common_name}-vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "ecs_vswitch1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_zones.default.ids.0
  vswitch_name = "${var.common_name}-vsw"
}

resource "alicloud_vswitch" "rds_vswitch2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_db_zones.default.ids.0
  vswitch_name = "${var.common_name}-vsw"
}

resource "alicloud_security_group" "security_group" {
  security_group_name = "${var.common_name}-sg"
  vpc_id              = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "security_group_ingress_443" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "security_group_ingress_80" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "security_group_ingress_3306" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "3306/3306"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "ecs_instance" {
  instance_name              = "${var.common_name}-ecs"
  image_id                   = data.alicloud_images.instance_image.images[0].id
  instance_type              = data.alicloud_instance_types.default.ids.0
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.ecs_vswitch1.id
  system_disk_category       = "cloud_essd"
  internet_max_bandwidth_out = 100
  password                   = var.ecs_instance_password
}

resource "alicloud_db_instance" "rds_instance" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_type            = data.alicloud_db_instance_classes.default.ids.0
  instance_storage         = 40
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
  vpc_id                   = alicloud_vpc.vpc.id
  vswitch_id               = alicloud_vswitch.rds_vswitch2.id
  security_group_ids       = [alicloud_security_group.security_group.id]
  security_ips             = ["192.168.0.0/24"]
}

resource "alicloud_rds_account" "create_db_user" {
  db_instance_id   = alicloud_db_instance.rds_instance.id
  account_name     = var.db_user_name
  account_password = var.db_password
  account_type     = "Super"
}

resource "alicloud_db_database" "rds_database" {
  name          = var.database_name
  description   = "${var.database_name} database"
  instance_id   = alicloud_db_instance.rds_instance.id
  character_set = "utf8mb4"
}

locals {
  install_java_script = <<-SHELL
    #!/bin/bash
    # 环境变量配置
    export PATH=/usr/local/bin:$PATH

    echo "export APPLETS_RDS_ENDPOINT=${alicloud_db_instance.rds_instance.connection_string}" >> ~/.bashrc
    echo "export APPLETS_RDS_USER=${var.db_user_name}" >> ~/.bashrc
    echo "export APPLETS_RDS_PASSWORD=${var.db_password}" >> ~/.bashrc
    echo "export APPLETS_RDS_DB_NAME=${var.database_name}" >> ~/.bashrc
    source ~/.bashrc

    # 网络检查地址
    NETWORK_CHECk_ADDR="help-static-aliyun-doc.aliyuncs.com"

    function unsupported_system() {
        log_fatal 1 "Unsupported System: $1"
    }

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

    function check_network_available() {
        log_info "ping $NETWORK_CHECk_ADDR ..."
        if ! debug_exec ping -c 4 $NETWORK_CHECk_ADDR; then
            log_fatal 2 "Could not connect to https://$NETWORK_CHECk_ADDR"
        fi
    }

    function install_java() {
        log_info "install java"
        yum upgrade & yum install java-1.8.0-openjdk-devel -y
    }

    function init_database() {
        log_info "install mysql 1.20.1"
        yum install -y mysql
        mysql -h $APPLETS_RDS_ENDPOINT -u $APPLETS_RDS_USER -p$APPLETS_RDS_PASSWORD < /data/script.sql
    }

    log_info "System Information:"
    if ! lsb_release -a; then
        unsupported_system
    fi;
    echo ""

    check_network_available

    mkdir -p /data
    cat <<"EOF" >> /data/script.sql
    -- script.sql
    USE ${var.database_name};
    CREATE TABLE `todo_list` (
      `id` bigint NOT NULL COMMENT 'id',
      `title` varchar(128) NOT NULL COMMENT 'title',
      `desc` text NOT NULL COMMENT 'description',
      `status` varchar(128) NOT NULL COMMENT 'status 未开始、进行中、已完成、已取消',
      `priority` varchar(128) NOT NULL COMMENT 'priority 高、中、低',
      `expect_time` datetime COMMENT 'expect time',
      `actual_completion_time` datetime COMMENT 'actual completion time',
      `gmt_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
      `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'modified time',
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    ;
    INSERT INTO todo_list
    (id, title, `desc`, `status`, priority, expect_time)
    value(1,  "创建一个小程序", "使用阿里云解决方案快速搭建一个App应用", "进行中", "高", "2024-04-01 00:00:00")

    EOF

    if ! debug_exec install_java; then
        log_fatal 3 "install java failed"
    fi

    if ! debug_exec init_database; then
        log_fatal 4 "init database failed"
    fi
    SHELL
}

resource "alicloud_ecs_command" "install_java" {
  depends_on      = [alicloud_db_database.rds_database]
  name            = "install-java-and-init-db"
  command_content = base64encode(local.install_java_script)
  description     = "Install Java and Initialize Database"
  type            = "RunShellScript"
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "invoke_install_java" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.install_java.id
}

resource "alicloud_dns_record" "domain_record" {
  count = var.domain_name == null ? 0 : 1

  # 解析 domain_name JSON 字符串，提取 domain_name 字段
  name = var.domain_name.domain_name

  # 解析 domain_name JSON 字符串，提取 domain_prefix 字段
  host_record = var.domain_name.domain_prefix != "" && var.domain_name.domain_prefix != null ? var.domain_name.domain_prefix : "@"
  type        = "A"
  value       = alicloud_instance.ecs_instance.public_ip
}