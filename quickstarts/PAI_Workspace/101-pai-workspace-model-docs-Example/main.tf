variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_pai_workspace_workspace" "defaultENuC6u" {
  description    = "156"
  display_name   = var.name
  workspace_name = "${var.name}_${random_integer.default.result}"
  env_types      = ["prod"]
}

resource "alicloud_pai_workspace_model" "default" {
  origin        = "Civitai"
  task          = "text-to-image-synthesis"
  model_name    = var.name
  accessibility = "PRIVATE"
  workspace_id  = alicloud_pai_workspace_workspace.defaultENuC6u.id
  model_type    = "Checkpoint"
  labels {
    key   = "base_model"
    value = "SD 1.5"
  }
  order_number = "1"
  extra_info = {
    test = "15"
  }
  model_description = "ModelDescription."
  model_doc         = "https://eas-***.oss-cn-hangzhou.aliyuncs.com/s**.safetensors"
  domain            = "aigc"
}