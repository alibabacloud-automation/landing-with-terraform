provider "alicloud" {
  region = "cn-hangzhou"
}

# 设置资源名称
variable "name" {
  default = "tf_test"
}

# 设置产品系列，按量付费类型实例只支持Basic、HighAvailability、cluster。
variable "db_category" {
  default = "Basic"
}

# 设置实例规格
variable "instance_type" {
  default = "pg.n2.2c.1m"
}

# 设置实例存储类型
variable "db_instance_storage_type" {
  default = "cloud_essd"
}

# 设置数据库版本
variable "engine_version" {
  default = "14.0"
}

# 设置存储空间
variable "instance_storage" {
  default = "20"
}

# 设置RDS账号名称
variable "account_name" {
  default = "tf_example"
}

# 设置RDS账号的密码
variable "account_password" {
  default = "!Qaz1234"
}

#设置外网连接地址的前缀
variable "connection_prefix" {
  default = "test1234"
}

# 查询符合以下要求的可用区
data "alicloud_db_zones" "default" {
  engine                   = "PostgreSQL"
  engine_version           = var.engine_version
  instance_charge_type     = "PostPaid"
  category                 = var.db_category
  db_instance_storage_type = var.db_instance_storage_type
}

# 专有网络
resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.1.0.0/21"
}

# 交换机
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.1.1.0/24"
  zone_id      = data.alicloud_db_zones.default.zones[0].id
}

# RDS数据库实例
resource "alicloud_db_instance" "default" {
  engine                   = "PostgreSQL"
  engine_version           = var.engine_version
  instance_type            = var.instance_type
  category                 = var.db_category
  db_instance_storage_type = var.db_instance_storage_type
  instance_storage         = var.instance_storage
  instance_charge_type     = "Postpaid"
  instance_name            = var.name
  vswitch_id               = alicloud_vswitch.default.id
}

# ProgresSQL数据库
resource "alicloud_db_database" "default" {
  instance_id = alicloud_db_instance.default.id
  name        = var.name
}

# RDS账号
resource "alicloud_rds_account" "default" {
  db_instance_id   = alicloud_db_instance.default.id
  account_name     = var.account_name
  account_password = var.account_password
}

# 授权账号访问数据库
resource "alicloud_db_account_privilege" "default" {
  instance_id  = alicloud_db_instance.default.id
  account_name = alicloud_rds_account.default.account_name
  privilege    = "DBOwner"
  db_names     = [alicloud_db_database.default.name]
}

# 申请外网连接地址
resource "alicloud_db_connection" "default" {
  instance_id       = alicloud_db_instance.default.id
  connection_prefix = var.connection_prefix
}
