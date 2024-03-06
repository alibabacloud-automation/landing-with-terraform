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
resource "alicloud_kms_key" "example" {
  description            = "terraform-example"
  pending_window_in_days = "7"
  status                 = "Enabled"
}

resource "alicloud_log_project" "example" {
  name        = "terraform-example-${random_integer.default.result}"
  description = "terraform-example"
}

resource "alicloud_log_store" "example" {
  project               = alicloud_log_project.example.name
  name                  = "example-store"
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