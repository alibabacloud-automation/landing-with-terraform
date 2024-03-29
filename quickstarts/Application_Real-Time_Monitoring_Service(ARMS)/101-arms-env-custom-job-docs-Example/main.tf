provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  max = 99999
  min = 10000
}

variable "name" {
  default = "terraform-example"
}

resource "alicloud_vpc" "vpc" {
  description = var.name
  cidr_block  = "172.16.0.0/12"
  vpc_name    = var.name
}

resource "alicloud_arms_environment" "env-ecs" {
  environment_type     = "ECS"
  environment_name     = "terraform-example-${random_integer.default.result}"
  bind_resource_id     = alicloud_vpc.vpc.id
  environment_sub_type = "ECS"
}

resource "alicloud_arms_env_custom_job" "default" {
  status              = "run"
  environment_id      = alicloud_arms_environment.env-ecs.id
  env_custom_job_name = var.name
  config_yaml         = <<EOF
scrape_configs:
- job_name: job-demo1
  honor_timestamps: false
  honor_labels: false
  scrape_interval: 30s
  scheme: http
  metrics_path: /metric
  static_configs:
  - targets:
    - 127.0.0.1:9090
EOF
  aliyun_lang         = "en"
}