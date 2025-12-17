variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = "cn-hangzhou-h"
}

resource "alicloud_security_group" "security_group" {
  description         = "terraform_example_group"
  security_group_name = "terraform_example_group"
  vpc_id              = data.alicloud_vpcs.default.ids.0
  security_group_type = "normal"
  inner_access_policy = "Accept"
}

resource "alicloud_dms_enterprise_workspace" "workspace" {
  description    = "terraform-example"
  vpc_id         = data.alicloud_vpcs.default.ids.0
  workspace_name = "terraform-example"
}


resource "alicloud_dms_airflow" "default" {
  vpc_id                     = data.alicloud_vpcs.default.ids.0
  oss_path                   = "/"
  dags_dir                   = "default/dags"
  zone_id                    = "cn-hangzhou-h"
  worker_serverless_replicas = "0"
  description                = "terraform-example"
  security_group_id          = alicloud_security_group.security_group.id
  requirement_file           = "default/requirements.txt"
  airflow_name               = "tfaccdms6513"
  plugins_dir                = "default/plugins"
  startup_file               = "default/startup.sh"
  app_spec                   = "SMALL"
  oss_bucket_name            = "hansheng"
  vswitch_id                 = data.alicloud_vswitches.default.ids.0
  workspace_id               = alicloud_dms_enterprise_workspace.workspace.id
}