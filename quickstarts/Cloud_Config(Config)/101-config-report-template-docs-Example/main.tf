variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_config_report_template" "default" {
  report_granularity = "AllInOne"
  report_scope {
    key        = "RuleId"
    value      = "cr-xxx"
    match_type = "In"
  }
  report_file_formats         = "excel"
  report_template_name        = "example-name"
  report_template_description = "example-desc"
  subscription_frequency      = " "
  report_language             = "en-US"
}