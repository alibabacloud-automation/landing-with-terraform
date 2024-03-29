variable "source_region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  alias  = "source"
  region = var.source_region
}

data "alicloud_hbr_replication_vault_regions" "default" {}

provider "alicloud" {
  alias  = "replication"
  region = data.alicloud_hbr_replication_vault_regions.default.regions.0.replication_region_id
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_hbr_vault" "default" {
  provider   = alicloud.source
  vault_name = "terraform-example-${random_integer.default.result}"
}

resource "alicloud_hbr_replication_vault" "default" {
  provider                     = alicloud.replication
  replication_source_region_id = var.source_region
  replication_source_vault_id  = alicloud_hbr_vault.default.id
  vault_name                   = "terraform-example"
  vault_storage_class          = "STANDARD"
  description                  = "terraform-example"
}