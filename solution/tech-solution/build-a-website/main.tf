# 查询RDS支持的可用区
data "alicloud_db_zones" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

locals {
  # 获取最后一个可用区
  zone_id = data.alicloud_db_zones.default.ids[length(data.alicloud_db_zones.default.ids) - 1]
}

# 查询实例规格
data "alicloud_db_instance_classes" "default" {
  instance_charge_type     = "PostPaid"
  engine                   = "MySQL"
  engine_version           = "8.0"
  db_instance_storage_type = "cloud_essd"
  category                 = "Basic"
  zone_id                  = local.zone_id
}

# VPC资源定义
resource "alicloud_vpc" "vpc" {
  vpc_name   = "${var.app_name}-vpc"
  cidr_block = "192.168.0.0/16"
}

# VSwitch资源定义
resource "alicloud_vswitch" "vswitch_1" {
  zone_id      = local.zone_id
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  vswitch_name = "${var.app_name}-vsw"
}

# RDS实例定义
resource "alicloud_db_instance" "rds_instance" {
  engine           = "MySQL"
  engine_version   = "8.0"
  instance_type    = data.alicloud_db_instance_classes.default.ids.0
  instance_storage = 40
  vpc_id           = alicloud_vpc.vpc.id
  vswitch_id       = alicloud_vswitch.vswitch_1.id
  security_ips     = [alicloud_vpc.vpc.cidr_block, "101.200.211.106"]
}

# RDS数据库定义
resource "alicloud_db_database" "rds_database" {
  name          = var.db_name
  description   = "database for mobi app"
  instance_id   = alicloud_db_instance.rds_instance.id
  character_set = "utf8mb4"
}

# RDS账号定义
resource "alicloud_rds_account" "create_db_user" {
  db_instance_id   = alicloud_db_instance.rds_instance.id
  account_name     = var.db_user_name
  account_password = var.db_password
  account_type     = "Super"
}

resource "random_integer" "app_name_random" {
  min = 10000
  max = 99999
}

resource "alicloud_db_connection" "rds_connection" {
  depends_on        = [alicloud_rds_account.create_db_user]
  instance_id       = alicloud_db_instance.rds_instance.id
  connection_prefix = "mobiapp${random_integer.app_name_random.result}"
}

# ROS Stack定义
resource "alicloud_ros_stack" "mobi_stack" {
  depends_on    = [alicloud_db_connection.rds_connection]
  stack_name    = "mobi-app-stack-${random_integer.app_name_random.result}"
  template_body = local.mobi_stack_json
}

locals {
  mobi_stack_json = <<-JSON
  {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
      "MobiWorkspaces": {
        "Type": "DATASOURCE::MOBI::Workspaces"
      },
      "Mobi": {
        "Type": "ALIYUN::MOBI::App",
        "Properties": {
          "AppName": "test_${random_integer.app_name_random.result}",
          "AppIcon": -1,
          "AppWorkspaceId": {
            "Fn::Select": [
              0,
              {
                "Fn::GetAtt": [
                  "MobiWorkspaces",
                  "WorkspaceIds"
                ]
              }
            ]
          },
          "AppType": "Web",
          "Template": {
            "TemplateId": "e1e78223-38c4-4184-972c-ac0eead93e11",
            "ConnectionsContent": "[{\n  \"name\": \"企业官网模板_${random_integer.app_name_random.result}\",\n  \"connectorType\": {\n    \"kind\": \"mysql\",\n    \"name\": \"mysql\"\n  },\n  \"folderId\": \"/\",\n  \"resourceRequirementId\": \"7dfe969b-1d54-4cbc-a8fd-209000b30ad0\",\n  \"resourceObject\": {\n    \"version\": \"1.0\",\n    \"id\": \"7dfe969b-1d54-4cbc-a8fd-209000b30ad0\",\n    \"name\": \"企业官网模板_20241203160633\",\n    \"type\": \"sql\",\n    \"subType\": \"mysql\",\n    \"connectionTemplates\": {\n      \"dev\": {\n        \"host\": \"${alicloud_db_connection.rds_connection.connection_string}\",\n        \"port\": 3306,\n        \"database\": \"${var.db_name}\",\n        \"username\": \"${var.db_user_name}\",\n        \"password\": \"${var.db_password}\"\n      },\n      \"product\": {\n        \"host\": \"${alicloud_db_connection.rds_connection.connection_string}\",\n        \"port\": 3306,\n        \"database\": \"${var.db_name}\",\n        \"username\": \"${var.db_user_name}\",\n        \"password\": \"${var.db_password}\"\n      }\n    }\n  }\n}]"
          }
        }
      }
    }
  }
  JSON
}