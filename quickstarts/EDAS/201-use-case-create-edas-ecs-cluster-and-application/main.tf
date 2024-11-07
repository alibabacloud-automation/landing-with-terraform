variable "region" {
  default = "cn-shanghai"
}

variable "instance_type" {
  type    = string
  default = "ecs.e-c1m1.large"
}

variable "vpc_cidr_block" {
  default = "172.16.0.0/16"
}

variable "vsw_cidr_block" {
  default = "172.16.0.0/24"
}

# 官网demo地址
variable "war_url" {
  type    = string
  default = "http://edas-sz.oss-cn-shenzhen.aliyuncs.com/prod/demo/SPRING_CLOUD_CONSUMER.jar"
}

provider "alicloud" {
  region = var.region
}

# 截取应用分组ID
locals {
  parts    = split(":", alicloud_edas_deploy_group.this.id)
  group_id = local.parts[2]
}

data "alicloud_zones" "default" {
  available_instance_type     = var.instance_type
  available_resource_creation = "VSwitch"
  available_disk_category     = "cloud_essd"
}

# 随机数
resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 创建专有网络VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc-test_${random_integer.default.result}"
  cidr_block = var.vpc_cidr_block
}

# 创建安全组
resource "alicloud_security_group" "group" {
  name   = "test_${random_integer.default.result}"
  vpc_id = alicloud_vpc.vpc.id
}

# 创建交换机
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vsw_cidr_block
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "vswitch-test-${random_integer.default.result}"
}

# 创建ECS
resource "alicloud_instance" "instance" {
  availability_zone          = data.alicloud_zones.default.zones[0].id
  security_groups            = alicloud_security_group.group.*.id
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  system_disk_name           = "test_foo_system_disk_${random_integer.default.result}"
  system_disk_description    = "test_foo_system_disk_description"
  image_id                   = "aliyun_2_1903_x64_20G_alibase_20240628.vhd"
  instance_name              = "test_ecs_${random_integer.default.result}"
  vswitch_id                 = alicloud_vswitch.vswitch.id
  internet_max_bandwidth_out = 10
  password                   = "Terraform@Example"
}

resource "time_sleep" "example" {
  depends_on      = [alicloud_instance.instance]
  create_duration = "60s"
}

# 创建ECS集群
resource "alicloud_edas_cluster" "cluster" {
  cluster_name      = "tf-edas-${random_integer.default.result}"
  cluster_type      = "2"
  network_mode      = "2"
  logical_region_id = var.region
  vpc_id            = alicloud_vpc.vpc.id
}

# 添加ECS实例到ECS集群
resource "alicloud_edas_instance_cluster_attachment" "default" {
  depends_on   = [time_sleep.example]
  cluster_id   = alicloud_edas_cluster.cluster.id
  instance_ids = [alicloud_instance.instance.id]
}

# 创建应用
resource "alicloud_edas_application" "app" {
  application_name = "tf-test-app-${random_integer.default.result}"
  cluster_id       = alicloud_edas_cluster.cluster.id
  package_type     = "JAR"
}

# 创建应用分组
resource "alicloud_edas_deploy_group" "this" {
  app_id     = alicloud_edas_application.app.id
  group_name = "tf-test-group-${random_integer.default.result}"
}

# 应用扩容
resource "alicloud_edas_application_scale" "default" {
  app_id       = alicloud_edas_application.app.id
  deploy_group = local.group_id
  ecu_info     = [alicloud_edas_instance_cluster_attachment.default.ecu_map[alicloud_instance.instance.id]]
}

# 部署应用
resource "alicloud_edas_application_deployment" "default" {
  depends_on = [alicloud_edas_application_scale.default, alicloud_edas_instance_cluster_attachment.default]
  app_id     = alicloud_edas_application.app.id
  group_id   = local.group_id
  war_url    = var.war_url
}

resource "time_sleep" "example2" {
  depends_on      = [alicloud_edas_application_deployment.default]
  create_duration = "60s"
}

# 创建SLB
resource "alicloud_slb_load_balancer" "default" {
  load_balancer_name = "tf-test-slb-${random_integer.default.result}"
  vswitch_id         = alicloud_vswitch.vswitch.id
  load_balancer_spec = "slb.s2.small"
  address_type       = "intranet"
}

# 绑定SLB
resource "alicloud_edas_slb_attachment" "this" {
  depends_on = [time_sleep.example2]
  app_id     = alicloud_edas_application.app.id
  slb_id     = alicloud_slb_load_balancer.default.id
  slb_ip     = alicloud_slb_load_balancer.default.address
  type       = alicloud_slb_load_balancer.default.address_type
}
