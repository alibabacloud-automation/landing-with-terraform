variable "region" {
  default = "cn-heyuan"
}

variable "zone_id" {
  default = "cn-heyuan-b"
}

variable "instance_type" {
  default = "pg.n2.2c.2m"
}

provider "alicloud" {
  region = var.region
}

# 创建VPC
resource "alicloud_vpc" "main" {
  vpc_name   = "alicloud"
  cidr_block = "172.16.0.0/16"
}

# 创建交换机
resource "alicloud_vswitch" "main" {
  vpc_id     = alicloud_vpc.main.id
  cidr_block = "172.16.192.0/20"
  zone_id    = var.zone_id
}

# 创建RDS PostgreSQL实例
resource "alicloud_db_instance" "instance" {
  engine               = "PostgreSQL"
  engine_version       = "13.0"
  instance_type        = var.instance_type
  instance_storage     = "30"
  instance_charge_type = "Postpaid"
  vswitch_id           = alicloud_vswitch.main.id
}

# 创建备份
resource "alicloud_rds_backup" "instance" {
  db_instance_id    = alicloud_db_instance.instance.id
  remove_from_state = true
}

# 查询备份
data "alicloud_rds_backups" "example" {
  db_instance_id = alicloud_db_instance.instance.id
  depends_on     = [alicloud_rds_backup.instance]
}

# 按时间点恢复实例
resource "alicloud_rds_clone_db_instance" "clone_time" {
  source_db_instance_id    = alicloud_db_instance.instance.id
  db_instance_description  = "terraform-test-clone"
  db_instance_storage_type = "cloud_essd"
  payment_type             = "PayAsYouGo"
  # 模拟获取查询结果中backup_end_time的参数取值。
  restore_time        = data.alicloud_rds_backups.example.backups.0.backup_end_time
  db_instance_storage = "50"
}

# 按备份集恢复实例
resource "alicloud_rds_clone_db_instance" "clone_id" {
  db_instance_description  = "terraform-test-clone-1"
  source_db_instance_id    = alicloud_db_instance.instance.id
  db_instance_storage_type = "cloud_essd"
  payment_type             = "PayAsYouGo"
  # 模拟获取查询结果中backup_id的参数取值。
  backup_id           = data.alicloud_rds_backups.example.backups.0.backup_id
  db_instance_storage = "50"
}