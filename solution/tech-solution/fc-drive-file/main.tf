data "alicloud_db_zones" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "default" {
  zone_id                  = data.alicloud_db_zones.default.zones.0.id
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "PostPaid"
}

# Declare the data source
data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_db_zones.default.zones.0.id
  instance_type_family = "ecs.g7"
}

# ECS Instance
data "alicloud_images" "instance_image" {
  name_regex    = "^aliyun_3_x64_20G_alibase_*"
  most_recent   = true
  owners        = "system"
  instance_type = data.alicloud_instance_types.default.instance_types[0].id
}

# Generate random integer for unique naming
resource "random_id" "suffix" {
  byte_length = 4
}
locals {
  common_name = "file-processing-${random_id.suffix.hex}"
}

# VPC and Networking
resource "alicloud_vpc" "vpc" {
  vpc_name   = "${local.common_name}-vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "vswitch1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_db_zones.default.zones.0.id
  vswitch_name = "${local.common_name}-vsw-web"
}

resource "alicloud_vswitch" "vswitch2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_db_zones.default.zones.0.id
  vswitch_name = "${local.common_name}-vsw-db"
}

# Security Group
resource "alicloud_security_group" "security_group" {
  #security_group_name = "${local.common_name}-sg"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "security_group_rule_80" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
}

# RDS Instance
resource "alicloud_db_instance" "rds_instance" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_type            = data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  instance_storage         = 40
  db_instance_storage_type = "cloud_essd"
  vpc_id                   = alicloud_vpc.vpc.id
  vswitch_id               = alicloud_vswitch.vswitch2.id
  security_group_ids       = [alicloud_security_group.security_group.id]
  security_ips             = ["192.168.0.0/16"]
  category                 = "Basic"
  zone_id                  = data.alicloud_db_zones.default.zones.0.id
}

resource "alicloud_rds_account" "rds_account" {
  db_instance_id   = alicloud_db_instance.rds_instance.id
  account_name     = var.db_user_name
  account_password = var.db_password
  account_type     = "Super"
}

resource "alicloud_db_database" "rds_database" {
  instance_id    = alicloud_db_instance.rds_instance.id
  data_base_name = "applets"
  character_set  = "utf8mb4"
}

# OSS Bucket
resource "alicloud_oss_bucket" "oss_bucket" {
  bucket        = "${var.bucket_name}-oss-bucket"
  storage_class = "Standard"
  force_destroy = true

  cors_rule {
    allowed_methods = ["GET", "POST", "HEAD"]
    allowed_headers = ["*"]
    allowed_origins = ["*"]
  }
}

# RAM Role for Function Compute
resource "alicloud_ram_role" "fc_demo_role" {
  role_name   = "${local.common_name}-role"
  description = "FcDemoRole"
  force       = true

  assume_role_policy_document = jsonencode({
    Version = "1"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = ["ecs.aliyuncs.com", "fc.aliyuncs.com"]
      }
    }]
  })
}

# RAM Policy for Function Compute
resource "alicloud_ram_policy" "fc_demo_policy" {
  policy_name = "${local.common_name}-policy"
  description = "FcDemoPolicy"
  force       = true

  policy_document = jsonencode({
    Version = "1"
    Statement = [{
      Effect = "Allow"
      Action = [
        "oss:PutObject",
        "oss:GetObject",
        "oss:GetObjectMeta",
        "mns:ReceiveMessage",
        "mns:BatchReceiveMessage",
        "mns:DeleteMessage"
      ]
      Resource = ["*"]
    }]
  })
}

resource "alicloud_ram_role_policy_attachment" "fc_demo_policy_attachment" {
  role_name   = alicloud_ram_role.fc_demo_role.id
  policy_name = alicloud_ram_policy.fc_demo_policy.policy_name
  policy_type = "Custom"
}

resource "alicloud_ram_role_policy_attachment" "sts_assume_role_attachment" {
  role_name   = alicloud_ram_role.fc_demo_role.id
  policy_name = "AliyunSTSAssumeRoleAccess"
  policy_type = "System"
}


resource "alicloud_instance" "ecs_instance" {
  instance_name              = "${local.common_name}-ecs"
  image_id                   = data.alicloud_images.instance_image.images[0].id
  instance_type              = data.alicloud_instance_types.default.instance_types[0].id
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.vswitch1.id
  system_disk_category       = "cloud_essd"
  internet_max_bandwidth_out = 5
  password                   = var.ecs_instance_password
  role_name                  = alicloud_ram_role.fc_demo_role.id
}

# MNS Queue
resource "alicloud_message_service_queue" "queue" {
  queue_name = "${var.bucket_name}-oss-queue"
}

# ECS Run Command for Application Deployment
locals {
  ecs_deploy_command = <<-SHELL
#!/bin/bash

cat << EOF >> ~/.bashrc
export APPLETS_RDS_ENDPOINT="${alicloud_db_instance.rds_instance.connection_string}"
export APPLETS_RDS_USER="${var.db_user_name}"
export APPLETS_RDS_DB_NAME="applets"
export APPLETS_RDS_PASSWORD="${var.db_password}"
export ALIYUN_RAM_ROLE_NAME="${alicloud_ram_role.fc_demo_role.id}"
export ALIYUN_OSS_ENDPOINT="oss-cn-hangzhou.aliyuncs.com"
export ALIYUN_REGION_ID="cn-hangzhou"
export ALIYUN_OSS_BUCKET="${alicloud_oss_bucket.oss_bucket.bucket}"
export ECS_IP=`curl http://100.100.100.200/latest/meta-data/eipv4`
export ALIYUN_MNS_ENDPOINT="http://1234567890.mns.cn-hangzhou-internal.aliyuncs.com"
export ALIYUN_MNS_QUEUE="${var.bucket_name}-oss-queue"
export WANX_DEMO_USERNAME="${var.demo_user_name}"
export WANX_DEMO_PASSWORD="${var.demo_user_password}"

export ROS_DEPLOY=true
EOF

cat << EOF > ~/.ossutilconfig
[Credentials]
endpoint = oss-cn-hangzhou-internal.aliyuncs.com
mode = EcsRamRole
ecsRoleName = ${alicloud_ram_role.fc_demo_role.id}

EOF

function log_info() {
    printf "%s [INFO] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
}

function log_error() {
    printf "%s [ERROR] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
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

function pre_work(){
  source ~/.bashrc
  yum upgrade & yum install -y java-1.8.0-openjdk-devel unzip zip
  sudo -v ; curl https://gosspublic.alicdn.com/ossutil/install.sh | sudo bash

  wget -O fc-web-demo-job-jar-with-dependencies.jar https://help-static-aliyun-doc.aliyuncs.com/demos/fc-web-demo-job-jar-with-dependencies.jar
  zip fc-web-demo-job-jar-with-dependencies.jar.zip fc-web-demo-job-jar-with-dependencies.jar
  ossutil cp fc-web-demo-job-jar-with-dependencies.jar.zip oss://${alicloud_oss_bucket.oss_bucket.bucket}/fc-code/ -c ~/.ossutilconfig

}

debug_exec pre_work

curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/install-script/fc-drive-file/install.sh|bash
SHELL
}

resource "alicloud_ecs_command" "deploy_application_command" {
  name            = "${local.common_name}-deploy-command"
  description     = "Deploy application on ECS"
  type            = "RunShellScript"
  command_content = base64encode(local.ecs_deploy_command)
  timeout         = 300
}

resource "alicloud_ecs_invocation" "deploy_application_invocation" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.deploy_application_command.id

  timeouts {
    create = "10m"
  }
}

# Function Compute Service
resource "alicloud_fc_service" "fc_service" {
  name            = "${local.common_name}-service"
  internet_access = true
  role            = alicloud_ram_role.fc_demo_role.arn
}

# Function Compute Function
resource "alicloud_fc_function" "fc_function" {
  service     = alicloud_fc_service.fc_service.name
  name        = "${local.common_name}-function"
  runtime     = "java11"
  handler     = "com.aliyun.demo.Main::handleRequest"
  memory_size = 1024
  timeout     = 120

  oss_bucket = alicloud_oss_bucket.oss_bucket.bucket
  oss_key    = "fc-code/fc-web-demo-job-jar-with-dependencies.jar.zip"

  depends_on = [alicloud_ecs_invocation.deploy_application_invocation]
}

data "alicloud_ram_roles" "default" {
  name_regex = "AliyunOSSEventNotificationRole"
}

locals {
  oss_role_exists = length(data.alicloud_ram_roles.default.names) > 0
}

# OSS Event Notification Role
resource "alicloud_ram_role" "oss_event_notification_role" {
  count       = local.oss_role_exists ? 0 : 1
  role_name   = "AliyunOSSEventNotificationRole"
  description = "OSS默认使用此角色来发送事件通知"

  assume_role_policy_document = jsonencode({
    Version = "1"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = ["oss.aliyuncs.com"]
      }
    }]
  })
}

resource "alicloud_ram_role_policy_attachment" "oss_event_notification_policy" {
  count       = local.oss_role_exists ? 0 : 1
  role_name   = alicloud_ram_role.oss_event_notification_role[0].id
  policy_name = "AliyunOSSEventNotificationRolePolicy"
  policy_type = "System"
}

# 获取当前账户ID
data "alicloud_caller_identity" "current" {}

# Function Compute Trigger
resource "alicloud_fc_trigger" "fc_trigger" {
  service  = alicloud_fc_service.fc_service.name
  function = alicloud_fc_function.fc_function.name
  name     = "oss-trigger"
  type     = "oss"

  config = jsonencode({
    events = [
      "oss:ObjectCreated:PutObject",
      "oss:ObjectCreated:PostObject",
      "oss:ObjectCreated:CompleteMultipartUpload"
    ]
    filter = {
      key = {
        prefix = "source"
        suffix = ""
      }
    }
  })

  source_arn = "acs:oss:cn-hangzhou:${data.alicloud_caller_identity.current.account_id}:${alicloud_oss_bucket.oss_bucket.bucket}"
  role       = "acs:ram::${data.alicloud_caller_identity.current.account_id}:role/AliyunOSSEventNotificationRole"
}