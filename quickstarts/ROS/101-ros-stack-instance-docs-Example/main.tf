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

resource "alicloud_ros_stack_instance" "example" {
  stack_group_name          = alicloud_ros_stack_group.default.stack_group_name
  stack_instance_account_id = data.alicloud_account.this.id
  stack_instance_region_id  = data.alicloud_ros_regions.default.regions.0.region_id
  operation_preferences     = "{\"FailureToleranceCount\": 1, \"MaxConcurrentCount\": 2}"
  timeout_in_minutes        = "60"
  operation_description     = "tf-example"
  retain_stacks             = "true"
  parameter_overrides {
    parameter_value = "VpcName"
    parameter_key   = "VpcName"
  }
}