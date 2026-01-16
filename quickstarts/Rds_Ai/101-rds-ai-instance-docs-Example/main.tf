variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_vswitches" "default" {
  zone_id = "cn-hangzhou-i"
}

resource "alicloud_db_instance" "default" {
  engine                   = "PostgreSQL"
  engine_version           = "17.0"
  db_instance_storage_type = "general_essd"
  instance_type            = "pg.n2.1c.1m"
  instance_storage         = 100
  vswitch_id               = data.alicloud_vswitches.default.ids.0
  instance_name            = var.name
}

resource "alicloud_rds_ai_instance" "default" {
  app_name         = var.name
  app_type         = "supabase"
  db_instance_name = alicloud_db_instance.default.id
}