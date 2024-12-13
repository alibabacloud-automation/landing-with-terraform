variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "pipelineExecution-vpc" {
  description = "example-pipeline"
  enable_ipv6 = true
  vpc_name    = var.name
}

resource "alicloud_vswitch" "vs" {
  description  = "pipelineExecution-start"
  vpc_id       = alicloud_vpc.pipelineExecution-vpc.id
  cidr_block   = "172.16.0.0/24"
  vswitch_name = format("%s1", var.name)
  zone_id      = "cn-hangzhou-i"
}

resource "alicloud_ecs_image_pipeline" "pipelineExection-pipeline" {
  base_image_type            = "IMAGE"
  description                = "example"
  system_disk_size           = "40"
  vswitch_id                 = alicloud_vswitch.vs.id
  add_account                = ["1284387915995949"]
  image_name                 = "example-image-pipeline"
  delete_instance_on_failure = true
  internet_max_bandwidth_out = "5"
  to_region_id               = ["cn-beijing"]
  base_image                 = "aliyun_3_x64_20G_dengbao_alibase_20240819.vhd"
  build_content              = "COMPONENT ic-bp122acttbs2sxdyq2ky"
}


resource "alicloud_ecs_image_pipeline_execution" "default" {
  image_pipeline_id = alicloud_ecs_image_pipeline.pipelineExection-pipeline.id
}