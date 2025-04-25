variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-wulanchabu"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_eflo_experiment_plan_template" "defaultpSZN7t" {
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

resource "alicloud_eflo_resource" "default" {
  user_access_param {
    access_id    = "your_access_id"
    access_key   = "your_access_key"
    workspace_id = "your_workspace_id"
    endpoint     = "your_endpoint"
  }
  cluster_id = "terraform-${random_integer.default.result}"
  machine_types {
    memory_info  = "32x 64GB DDR4 4800 Memory"
    type         = "Private"
    bond_num     = "5"
    node_count   = "1"
    cpu_info     = "2x Intel Saphhire Rapid 8469C 48C CPU"
    network_info = "1x 200Gbps Dual Port BF3 DPU for VPC 4x 200Gbps Dual Port EIC"
    gpu_info     = "8x OAM 810 GPU"
    disk_info    = "2x 480GB SATA SSD 4x 3.84TB NVMe SSD"
    network_mode = "net"
    name         = "lingjun"
  }
  cluster_name = var.name
  cluster_desc = var.name
}

resource "alicloud_eflo_experiment_plan" "default" {
  resource_id = alicloud_eflo_resource.default.resource_id
  plan_name   = var.name
  template_id = alicloud_eflo_experiment_plan_template.defaultpSZN7t.id
}