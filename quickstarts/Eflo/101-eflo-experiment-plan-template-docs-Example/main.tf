variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-wulanchabu"
}

resource "alicloud_eflo_experiment_plan_template" "default" {
  template_pipeline {
    workload_id   = "2"
    workload_name = "MatMul"
    env_params {
      cpu_per_worker     = "90"
      gpu_per_worker     = "8"
      memory_per_worker  = "500"
      share_memory       = "500"
      worker_num         = "1"
      py_torch_version   = "1"
      gpu_driver_version = "1"
      cuda_version       = "1"
      nccl_version       = "1"
    }
    pipeline_order = "1"
    scene          = "baseline"
  }
  privacy_level        = "private"
  template_name        = var.name
  template_description = var.name
}