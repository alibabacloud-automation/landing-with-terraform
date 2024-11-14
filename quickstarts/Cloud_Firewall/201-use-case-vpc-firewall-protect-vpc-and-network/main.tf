variable "region" {
  default = "cn-qingdao"
}
provider "alicloud" {
  region = var.region
}
data "alicloud_account" "current" {
}
# 创建VPC 1
resource "alicloud_vpc" "vpc" {
  vpc_name   = "cen-vpc-01"
  cidr_block = "172.16.0.0/12"
}
# 创建VPC 2
resource "alicloud_vpc" "vpc1" {
  vpc_name   = "cen-vpc-02"
  cidr_block = "172.16.0.0/12"
}
# 创建一个Vswitch CIDR 块为 172.16.1.0/24
resource "alicloud_vswitch" "vsw" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "172.16.1.0/24"
  zone_id      = "cn-qingdao-b"
  vswitch_name = "terraform-example-1"
}
# 创建另一个Vswitch CIDR 块为 172.16.0.0/24
resource "alicloud_vswitch" "vsw1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = "cn-qingdao-c"
  vswitch_name = "terraform-example-2"
}
# 创建一个Vswitch CIDR 块为 172.16.4.0/24
resource "alicloud_vswitch" "vsw2" {
  vpc_id       = alicloud_vpc.vpc1.id
  cidr_block   = "172.16.4.0/24"
  zone_id      = "cn-qingdao-b"
  vswitch_name = "terraform-example-11"
}
# 创建另一个Vswitch CIDR 块为 172.16.5.0/24
resource "alicloud_vswitch" "vsw3" {
  vpc_id       = alicloud_vpc.vpc1.id
  cidr_block   = "172.16.5.0/24"
  zone_id      = "cn-qingdao-c"
  vswitch_name = "terraform-example-22"
}
# 云企业网实例
resource "alicloud_cen_instance" "example" {
  # CEN实例名称
  cen_instance_name = "tf_example"
  # 描述
  description = "an example for cen"
}
# 转发路由器创建网络实例连接 1
resource "alicloud_cen_instance_attachment" "example" {
  instance_id              = alicloud_cen_instance.example.id
  child_instance_id        = alicloud_vpc.vpc.id
  child_instance_type      = "VPC"
  child_instance_region_id = "cn-qingdao"
}
# 转发路由器创建网络实例连接 2
resource "alicloud_cen_instance_attachment" "example1" {
  instance_id              = alicloud_cen_instance.example.id
  child_instance_id        = alicloud_vpc.vpc1.id
  child_instance_type      = "VPC"
  child_instance_region_id = "cn-qingdao"
}
# 先创建云企业网实例和网络连接实例
resource "time_sleep" "wait_before_firewall" {
  # 确保云企业网实例，网络连接实例创建好后
  depends_on = [
    alicloud_cen_instance_attachment.example,
    alicloud_cen_instance_attachment.example1
  ]
  create_duration = "720s" # 根据需要设置延迟时间
}
# 延迟
resource "null_resource" "wait_for_firewall" {
  provisioner "local-exec" {
    command = "echo waiting for firewall to be ready"
  }
  # 确保云企业网实例创建
  depends_on = [time_sleep.wait_before_firewall]
}
# 云企业（基础版）实例
resource "alicloud_cloud_firewall_vpc_firewall_cen" "default" {
  # 云企业网实例，网络连接实例，延迟确保创建
  depends_on = [
    null_resource.wait_for_firewall
  ]
  timeouts {
    create = "30m" # 给创建加上超时时间
  }
  # CEN 实例的 ID
  cen_id = alicloud_cen_instance.example.id
  # VPC 的详细信息
  local_vpc {
    # 创建 VPC 防火墙的 VPC 实例 ID。
    network_instance_id = alicloud_cen_instance_attachment.example.child_instance_id
  }
  # 防火墙开关状态。
  status = "open"
  # 当前阿里云账户的成员账户 UID 可选
  member_uid = data.alicloud_account.current.id
  # 创建 VPC 的区域 ID。
  vpc_region = var.region
  # VPC 防火墙实例的名称。
  vpc_firewall_name = "tf-test"
}