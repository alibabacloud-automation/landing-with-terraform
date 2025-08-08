locals {
  zone_id_1 = data.alicloud_polardb_node_classes.default.classes[0].zone_id
  zone_id_2 = data.alicloud_zones.default.zones.0.id
}
# 生成随机后缀用于资源命名
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

data "alicloud_regions" "default" {
  current = true
}
data "alicloud_polardb_node_classes" "default" {
  db_type       = "MySQL"
  db_version    = "8.0"
  category      = "Normal"
  pay_type      = "PostPaid"
  db_node_class = "polar.mysql.sl.small"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

# 创建VPC
resource "alicloud_vpc" "main" {
  vpc_name   = "${var.common_name}-vpc"
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "${var.common_name}-vpc"
  }
}

# 创建交换机1 (Web层 - 可用区1)
resource "alicloud_vswitch" "web_01" {
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = local.zone_id_1
  vswitch_name = "${var.common_name}-web-01"

  tags = {
    Name = "${var.common_name}-web-01"
  }
}

# 创建交换机2 (Web层 - 可用区2)
resource "alicloud_vswitch" "web_02" {
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = "192.168.2.0/24"
  zone_id      = local.zone_id_2
  vswitch_name = "${var.common_name}-web-02"

  tags = {
    Name = "${var.common_name}-web-02"
  }
}

# 创建交换机3 (数据库层 - 可用区1)
resource "alicloud_vswitch" "db_01" {
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = "192.168.3.0/24"
  zone_id      = local.zone_id_1
  vswitch_name = "${var.common_name}-db-01"

  tags = {
    Name = "${var.common_name}-db-01"
  }
}

# 创建交换机4 (公网层 - 可用区1)
resource "alicloud_vswitch" "pub_01" {
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = "192.168.4.0/24"
  zone_id      = local.zone_id_1
  vswitch_name = "${var.common_name}-pub-01"

  tags = {
    Name = "${var.common_name}-pub-01"
  }
}

# 创建交换机5 (公网层 - 可用区2)
resource "alicloud_vswitch" "pub_02" {
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = "192.168.5.0/24"
  zone_id      = local.zone_id_2
  vswitch_name = "${var.common_name}-pub-02"

  tags = {
    Name = "${var.common_name}-pub-02"
  }
}

# 创建安全组
resource "alicloud_security_group" "main" {
  security_group_name = "${var.common_name}-sg"
  vpc_id              = alicloud_vpc.main.id
  description         = "Serverless高可用架构安全组"

  tags = {
    Name = "${var.common_name}-sg"
  }
}

# 安全组规则 - 允许HTTPS访问
resource "alicloud_security_group_rule" "allow_https" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  security_group_id = alicloud_security_group.main.id
  cidr_ip           = "0.0.0.0/0"
}

# 安全组规则 - 允许HTTP访问
resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  security_group_id = alicloud_security_group.main.id
  cidr_ip           = "0.0.0.0/0"
}

# 安全组规则 - 允许MySQL访问
resource "alicloud_security_group_rule" "allow_mysql" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "3306/3306"
  security_group_id = alicloud_security_group.main.id
  cidr_ip           = "0.0.0.0/0"
}

# 创建PolarDB集群
resource "alicloud_polardb_cluster" "main" {
  db_type            = "MySQL"
  db_version         = "8.0"
  db_node_class      = data.alicloud_polardb_node_classes.default.classes.0.supported_engines.0.available_resources.0.db_node_class
  pay_type           = "PostPaid"
  vswitch_id         = alicloud_vswitch.db_01.id
  zone_id            = local.zone_id_1
  security_group_ids = [alicloud_security_group.main.id]

  # Serverless配置
  serverless_type  = "AgileServerless"
  scale_min        = 1
  scale_max        = 16
  scale_ro_num_min = 1
  scale_ro_num_max = 4

  description = "Serverless高可用架构PolarDB集群"

  tags = {
    Name = "${var.common_name}-polardb"
  }

  lifecycle {
    ignore_changes = [allow_shut_down]
  }
}

# 创建数据库
resource "alicloud_polardb_database" "main" {
  db_cluster_id      = alicloud_polardb_cluster.main.id
  db_name            = "applets"
  character_set_name = "utf8mb4"
  db_description     = "serverless demo"

  lifecycle {
    ignore_changes = [account_name]
  }
}

# 创建数据库账号
resource "alicloud_polardb_account" "main" {
  db_cluster_id    = alicloud_polardb_cluster.main.id
  account_name     = var.db_user_name
  account_password = var.db_password
  account_type     = "Normal"
}

# 为账号授权数据库
resource "alicloud_polardb_account_privilege" "main" {
  db_cluster_id     = alicloud_polardb_cluster.main.id
  account_name      = alicloud_polardb_account.main.account_name
  db_names          = [alicloud_polardb_database.main.db_name]
  account_privilege = "ReadWrite"
}

# 创建应用负载均衡器(ALB)
resource "alicloud_alb_load_balancer" "main" {
  load_balancer_name     = "${var.common_name}-alb"
  load_balancer_edition  = "Basic"
  vpc_id                 = alicloud_vpc.main.id
  address_type           = "Internet"
  address_allocated_mode = "Fixed"

  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }

  zone_mappings {
    zone_id    = local.zone_id_1
    vswitch_id = alicloud_vswitch.web_01.id
  }

  zone_mappings {
    zone_id    = local.zone_id_2
    vswitch_id = alicloud_vswitch.web_02.id
  }

  tags = {
    Name = "${var.common_name}-alb"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# 创建SAE命名空间
resource "alicloud_sae_namespace" "main" {
  namespace_name = "serverless-demo"
  namespace_id   = "${data.alicloud_regions.default.regions.0.id}:serverless${random_string.suffix.result}"
}

# 创建SAE应用
resource "alicloud_sae_application" "main" {
  app_name        = "serverless-demo-${random_string.suffix.result}"
  app_description = "serverless-demo"
  namespace_id    = alicloud_sae_namespace.main.id

  package_type    = "FatJar"
  package_version = "1718956564756"
  package_url     = "https://help-static-aliyun-doc.aliyuncs.com/tech-solution/sae-demo-0.0.3.jar"

  vpc_id            = alicloud_vpc.main.id
  security_group_id = alicloud_security_group.main.id
  vswitch_id        = "${alicloud_vswitch.pub_01.id},${alicloud_vswitch.pub_02.id}"

  cpu      = 2000
  memory   = 4096
  replicas = 2

  jdk      = "Open JDK 8"
  timezone = "Asia/Shanghai"

  jar_start_args    = "$JAVA_HOME/bin/java $Options -jar $CATALINA_OPTS \"$package_path\" $args"
  jar_start_options = "-XX:+UseContainerSupport -XX:InitialRAMPercentage=70.0 -XX:MaxRAMPercentage=70.0 -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/home/admin/nas/gc-$${POD_IP}-$(date '+%s').log -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/home/admin/nas/dump-$${POD_IP}-$(date '+%s').hprof"

  envs = jsonencode([
    {
      name  = "APPLETS_MYSQL_ENDPOINT"
      value = alicloud_polardb_cluster.main.connection_string
    },
    {
      name  = "APPLETS_MYSQL_USER"
      value = var.db_user_name
    },
    {
      name  = "APPLETS_MYSQL_PASSWORD"
      value = var.db_password
    },
    {
      name  = "APPLETS_MYSQL_DB_NAME"
      value = "applets"
    },
    {
      name  = "APP_MANUAL_DEPLOY"
      value = "false"
    }
  ])

  readiness_v2 {
    exec {
      command = ["sleep", "6s"]
    }
    initial_delay_seconds = 15
    timeout_seconds       = 12
  }

  liveness_v2 {
    http_get {
      path   = "/"
      port   = 80
      scheme = "HTTP"
    }
    initial_delay_seconds = 10
    timeout_seconds       = 10
    period_seconds        = 10
  }

  tags = {
    Name = "serverless-demo-${random_string.suffix.result}"
  }

  lifecycle {
    ignore_changes = [envs]
  }
}

# 等待应用部署完成
resource "time_sleep" "wait_app" {
  depends_on      = [alicloud_sae_application.main]
  create_duration = "180s"
}

# 创建SAE Ingress规则
resource "alicloud_sae_ingress" "main" {
  depends_on   = [time_sleep.wait_app]
  namespace_id = alicloud_sae_namespace.main.id
  slb_id       = alicloud_alb_load_balancer.main.id
  description  = "serverless-demo-router"

  load_balance_type = "alb"
  listener_protocol = "HTTP"
  listener_port     = 80
  rules {
    app_name         = alicloud_sae_application.main.app_name
    app_id           = alicloud_sae_application.main.id
    container_port   = 80
    domain           = "example.com"
    path             = "/"
    backend_protocol = "http"
  }

  default_rule {
    app_id         = alicloud_sae_application.main.id
    container_port = 80
  }
}