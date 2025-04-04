variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_ram_password_policy" "default" {
  minimum_password_length              = "8"
  require_lowercase_characters         = false
  require_numbers                      = false
  max_password_age                     = "0"
  password_reuse_prevention            = "1"
  max_login_attemps                    = "1"
  hard_expiry                          = false
  require_uppercase_characters         = false
  require_symbols                      = false
  password_not_contain_user_name       = false
  minimum_password_different_character = "1"
}