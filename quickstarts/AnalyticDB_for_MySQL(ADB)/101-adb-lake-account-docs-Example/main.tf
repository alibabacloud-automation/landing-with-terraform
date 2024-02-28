variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "VPCID" {
  vpc_name = var.name

  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "VSWITCHID" {
  vpc_id       = alicloud_vpc.VPCID.id
  zone_id      = "cn-hangzhou-k"
  vswitch_name = var.name

  cidr_block = "172.16.0.0/24"
}

resource "alicloud_adb_db_cluster_lake_version" "CreateInstance" {
  storage_resource       = "0ACU"
  zone_id                = "cn-hangzhou-k"
  vpc_id                 = alicloud_vpc.VPCID.id
  vswitch_id             = alicloud_vswitch.VSWITCHID.id
  db_cluster_description = var.name
  compute_resource       = "16ACU"
  db_cluster_version     = "5.0"
  payment_type           = "PayAsYouGo"
  security_ips           = "127.0.0.1"
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