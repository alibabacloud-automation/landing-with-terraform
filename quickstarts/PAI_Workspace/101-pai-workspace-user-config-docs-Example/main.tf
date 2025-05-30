variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_pai_workspace_user_config" "default" {
  category_name = "DataPrivacyConfig"
  config_key    = "customizePAIAssumedRole"
  config_value  = var.name
}