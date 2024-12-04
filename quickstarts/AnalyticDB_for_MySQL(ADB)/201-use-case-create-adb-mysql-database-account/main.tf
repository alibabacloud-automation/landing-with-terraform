variable "name" {
  default = "terraform-example"
}

variable "region" {
  default = "cn-shenzhen"
}

variable "zone_id" {
  default = "cn-shenzhen-e"
}

provider "alicloud" {
  region = var.region
}

resource "alicloud_vpc" "default" {
  vpc_name   = "alicloud"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id     = alicloud_vpc.default.id
  cidr_block = "172.16.192.0/20"
  zone_id    = var.zone_id
}

resource "alicloud_adb_db_cluster_lake_version" "CreateInstance" {
  storage_resource              = "0ACU"
  zone_id                       = var.zone_id
  vpc_id                        = alicloud_vpc.default.id
  vswitch_id                    = alicloud_vswitch.default.id
  db_cluster_description        = var.name
  compute_resource              = "32ACU"
  db_cluster_version            = "5.0"
  payment_type                  = "PayAsYouGo"
  security_ips                  = "127.0.0.1"
  enable_default_resource_group = false
}

resource "alicloud_adb_lake_account" "default" {
  db_cluster_id    = alicloud_adb_db_cluster_lake_version.CreateInstance.id
  account_type     = "Super"
  account_name     = "tfnormal"
  account_password = "normal@2023"
  account_privileges {
    privilege_type = "Database"
    privilege_object {
      database = "MYSQL"
    }

    privileges = [
      "select",
      "update"
    ]
  }
  account_privileges {
    privilege_type = "Table"
    privilege_object {
      database = "INFORMATION_SCHEMA"
      table    = "ENGINES"
    }

    privileges = [
      "update"
    ]
  }
  account_privileges {
    privilege_type = "Column"
    privilege_object {
      table    = "COLUMNS"
      column   = "PRIVILEGES"
      database = "INFORMATION_SCHEMA"
    }

    privileges = [
      "update"
    ]
  }

  account_description = var.name
}