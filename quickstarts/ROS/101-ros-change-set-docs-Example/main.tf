resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ros_change_set" "example" {
  change_set_name = "example_value"
  stack_name      = "tf-example-${random_integer.default.result}"
  change_set_type = "CREATE"
  description     = "Test From Terraform"
  template_body   = "{\"ROSTemplateFormatVersion\":\"2015-09-01\"}"
}