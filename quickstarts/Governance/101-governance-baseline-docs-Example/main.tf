variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

variable "item_password_policy" {
  default = "ACS-BP_ACCOUNT_FACTORY_RAM_USER_PASSWORD_POLICY"
}

variable "baseline_name_update" {
  default = "tf-auto-example-baseline-update"
}

variable "item_services" {
  default = "ACS-BP_ACCOUNT_FACTORY_SUBSCRIBE_SERVICES"
}

variable "baseline_name" {
  default = "tf-auto-example-baseline"
}

variable "item_ram_security" {
  default = "ACS-BP_ACCOUNT_FACTORY_RAM_SECURITY_PREFERENCE"
}

resource "alicloud_governance_baseline" "default" {
  baseline_items {
    version = "1.0"
    name    = var.item_password_policy
    config  = jsonencode({ "MinimumPasswordLength" : 8, "RequireLowercaseCharacters" : true, "RequireUppercaseCharacters" : true, "RequireNumbers" : true, "RequireSymbols" : true, "MaxPasswordAge" : 0, "HardExpiry" : false, "PasswordReusePrevention" : 0, "MaxLoginAttempts" : 0 })
  }
  description   = var.name
  baseline_name = "${var.name}-${random_integer.default.result}"
}