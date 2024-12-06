variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_pai_workspace_workspace" "defaultAiWorkspace" {
  description    = var.name
  display_name   = var.name
  workspace_name = var.name
  env_types      = ["prod"]
}

resource "alicloud_pai_workspace_dataset" "defaultDataset" {
  accessibility    = "PRIVATE"
  source_type      = "USER"
  data_type        = "PIC"
  workspace_id     = alicloud_pai_workspace_workspace.defaultAiWorkspace.id
  options          = jsonencode({ "mountPath" : "/mnt/data/" })
  description      = var.name
  source_id        = "d-xxxxx_v1"
  uri              = "oss://ai4d-q9lgxlpwxzqluij66y.oss-cn-hangzhou.aliyuncs.com/"
  dataset_name     = format("%s1", var.name)
  user_id          = "1511928242963727"
  data_source_type = "OSS"
  property         = "DIRECTORY"
}


resource "alicloud_pai_workspace_datasetversion" "default" {
  options          = jsonencode({ "mountPath" : "/mnt/data/verion/" })
  description      = var.name
  data_source_type = "OSS"
  source_type      = "USER"
  source_id        = "d-xxxxx_v1"
  data_size        = "2068"
  data_count       = "1000"
  labels {
    key   = "key1"
    value = "example1"
  }
  uri        = "oss://ai4d-q9lgxlpwxzqluij66y.oss-cn-hangzhou.aliyuncs.com/"
  property   = "DIRECTORY"
  dataset_id = alicloud_pai_workspace_dataset.defaultDataset.id
}