variable "name" {
  default = "tf_example"
}

provider "alicloud" {
  region = "cn-chengdu"
}

resource "random_integer" "randint" {
  max = 999
  min = 1
}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_data_works_project" "defaultQeRfvU" {
  status                  = "Available"
  description             = "tf_desc"
  project_name            = "${var.name}${random_integer.randint.id}"
  pai_task_enabled        = "false"
  display_name            = "tf_new_api_display"
  dev_role_disabled       = "true"
  dev_environment_enabled = "false"
  resource_group_id       = data.alicloud_resource_manager_resource_groups.default.ids.0
}

resource "alicloud_data_works_data_source" "defaultvzu0wG" {
  type                       = "hive"
  data_source_name           = format("%s2", var.name)
  connection_properties      = jsonencode({ "address" : [{ "host" : "127.0.0.1", "port" : "1234" }], "database" : "hive_database", "metaType" : "HiveMetastore", "metastoreUris" : "thrift://123:123", "version" : "2.3.9", "loginMode" : "Anonymous", "securityProtocol" : "authTypeNone", "envType" : "Prod", "properties" : { "key1" : "value1" } })
  project_id                 = alicloud_data_works_project.defaultQeRfvU.id
  connection_properties_mode = "UrlMode"
}


resource "alicloud_data_works_data_source_shared_rule" "default" {
  target_project_id = alicloud_data_works_project.defaultasjsH5.id
  data_source_id    = alicloud_data_works_data_source.defaultvzu0wG.data_source_id
  env_type          = "Prod"
}