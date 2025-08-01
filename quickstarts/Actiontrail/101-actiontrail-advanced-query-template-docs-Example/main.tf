variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_actiontrail_advanced_query_template" "default" {
  simple_query  = true
  template_name = "exampleTemplateName"
  template_sql  = "*"
}