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

resource "alicloud_pai_workspace_workspace" "defaultDI9fsL" {
  description    = "802"
  display_name   = var.name
  workspace_name = "${var.name}_${random_integer.default.result}"
  env_types      = ["prod"]
}

resource "alicloud_pai_workspace_model" "defaultsHptEL" {
  model_name        = var.name
  workspace_id      = alicloud_pai_workspace_workspace.defaultDI9fsL.id
  origin            = "Civitai"
  task              = "text-to-image-synthesis"
  accessibility     = "PRIVATE"
  model_type        = "Checkpoint"
  order_number      = "1"
  model_description = "ModelDescription."
  model_doc         = "https://eas-***.oss-cn-hangzhou.aliyuncs.com/s**.safetensors"
  domain            = "aigc"
  labels {
    key   = "base_model"
    value = "SD 1.5"
  }
  extra_info = {
    test = "15"
  }
}

resource "alicloud_pai_workspace_model_version" "default" {
  version_description = "VersionDescription."
  source_type         = "TrainingService"
  source_id           = "region=$${region},workspaceId=$${workspace_id},kind=TrainingJob,id=job-id"
  extra_info = {
    test = "15"
  }
  training_spec = {
    test = "TrainingSpec"
  }
  uri = "oss://hz-example-0701.oss-cn-hangzhou-internal.aliyuncs.com/checkpoints/"
  inference_spec = {
    test = "InferenceSpec"
  }
  model_id        = alicloud_pai_workspace_model.defaultsHptEL.id
  format_type     = "SavedModel"
  approval_status = "Pending"
  framework_type  = "PyTorch"
  version_name    = "1.0.0"
  metrics = {
  }
  labels {
    key   = "k1"
    value = "vs1"
  }
}