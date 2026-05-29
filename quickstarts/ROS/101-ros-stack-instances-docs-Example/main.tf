variable "name" {
  default = "tf-example"
}

data "alicloud_account" "this" {
}

data "alicloud_ros_regions" "default" {}

resource "alicloud_ros_stack_group" "default" {
  stack_group_name = var.name
  template_body    = "{\"ROSTemplateFormatVersion\":\"2015-09-01\", \"Parameters\": {\"VpcName\": {\"Type\": \"String\"},\"InstanceType\": {\"Type\": \"String\"}}}"
  description      = "test for stack groups"
  parameters {
    parameter_key   = "VpcName"
    parameter_value = "VpcName"
  }
  parameters {
    parameter_key   = "InstanceType"
    parameter_value = "InstanceType"
  }
}

resource "alicloud_ros_stack_instances" "self_managed" {
  stack_group_name = alicloud_ros_stack_group.default.stack_group_name
  region_ids       = [data.alicloud_ros_regions.default.regions.0.region_id]
  account_ids      = [data.alicloud_account.this.id]

  parameter_overrides {
    parameter_value = "VpcName"
    parameter_key   = "VpcName"
  }
  timeout_in_minutes    = 45
  operation_description = "Batch deployment for production environment"
  disable_rollback      = false
}