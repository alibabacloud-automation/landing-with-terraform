variable "region" {
  description = "The region of kms key."
  default     = "cn-hangzhou"
}

provider "alicloud" {
  region  = var.region
  profile = "default"
}

data "alicloud_account" "example" {
}

resource "random_integer" "default" {
  max = 99999
  min = 10000
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_vswitches" "default" {
  vpc_id = data.alicloud_vpcs.default.ids.0
}

resource "alicloud_kms_instance" "default" {
  product_version = "3"
  vpc_id          = data.alicloud_vpcs.default.ids.0
  zone_ids = [
    data.alicloud_vswitches.default.vswitches.0.zone_id,
    data.alicloud_vswitches.default.vswitches.1.zone_id
  ]
  vswitch_ids = [
    data.alicloud_vswitches.default.ids.0
  ]
  vpc_num                     = "1"
  key_num                     = "1000"
  secret_num                  = "0"
  spec                        = "1000"
  force_delete_without_backup = true
  payment_type                = "PayAsYouGo"
}

resource "alicloud_kms_key" "example" {
  description            = "terraform-example"
  pending_window_in_days = "7"
  status                 = "Enabled"
  dkms_instance_id       = alicloud_kms_instance.default.id
}

resource "alicloud_log_project" "example" {
  project_name = "terraform-example-${random_integer.default.result}"
  description  = "terraform-example"
}

resource "alicloud_log_store" "example" {
  project_name          = alicloud_log_project.example.project_name
  logstore_name         = "example-store"
  shard_count           = 1
  auto_split            = true
  max_split_shard_count = 60
  encrypt_conf {
    enable       = true
    encrypt_type = "default"
    user_cmk_info {
      cmk_key_id = alicloud_kms_key.example.id
      arn        = "acs:ram::${data.alicloud_account.example.id}:role/aliyunlogdefaultrole"
      region_id  = var.region
    }
  }
}