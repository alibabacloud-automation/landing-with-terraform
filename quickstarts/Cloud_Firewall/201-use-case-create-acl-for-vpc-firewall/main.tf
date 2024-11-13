variable "region" {
  default = "cn-heyuan"
}
provider "alicloud" {
  region = var.region
}
# 获取当前阿里云uid
data "alicloud_account" "current" {
}
# 创建VPC 1
resource "alicloud_vpc" "vpc" {
  vpc_name   = "dd-tf-vpc-01"
  cidr_block = "192.168.0.0/16"
}
# 创建VPC 2
resource "alicloud_vpc" "vpc1" {
  vpc_name   = "dd-tf-vpc-02"
  cidr_block = "172.16.0.0/12"
}
# 创建一个Vswitch CIDR 块为 192.168.10.0/24
resource "alicloud_vswitch" "vsw" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.10.0/24"
  zone_id      = "cn-heyuan-a"
  vswitch_name = "dd-tf-vpc-01-example-1"
}
# 创建另一个Vswitch CIDR 块为 192.168.20.0/24
resource "alicloud_vswitch" "vsw1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.20.0/24"
  zone_id      = "cn-heyuan-b"
  vswitch_name = "dd-tf-vpc-01-example-2"
}
# 创建一个Vswitch CIDR 块为 172.16.10.0/24
resource "alicloud_vswitch" "vsw2" {
  vpc_id       = alicloud_vpc.vpc1.id
  cidr_block   = "172.16.10.0/24"
  zone_id      = "cn-heyuan-a"
  vswitch_name = "dd-tf-vpc-02-example-11"
}
# 创建另一个Vswitch CIDR 块为 172.16.20.0/24
resource "alicloud_vswitch" "vsw3" {
  vpc_id       = alicloud_vpc.vpc1.id
  cidr_block   = "172.16.20.0/24"
  zone_id      = "cn-heyuan-b"
  vswitch_name = "dd-tf-vpc-02-example-22"
}
# 创建VPC对等连接
resource "alicloud_vpc_peer_connection" "default" {
  # 对等连接名称
  peer_connection_name = "terraform-example-vpc-peer-connection"
  # 发起方VPC_ID
  vpc_id = alicloud_vpc.vpc.id
  # 接收方 VPC 对等连接的 Alibaba Cloud 账号 ID
  accepting_ali_uid = data.alicloud_account.current.id
  # 接收方 VPC 对等连接的区域 ID。同区域创建时，输入与发起方相同的区域 ID；跨区域创建时，输入不同的区域 ID。
  accepting_region_id = "cn-heyuan"
  # 接收端VPC_ID
  accepting_vpc_id = alicloud_vpc.vpc1.id
  # 描述
  description = "terraform-example"
  # 是否强制删除
  force_delete = true
}
# 接收端
resource "alicloud_vpc_peer_connection_accepter" "default" {
  instance_id = alicloud_vpc_peer_connection.default.id
}
# 配置路由条目-vpc-A
resource "alicloud_route_entry" "foo" {
  # VPC-A 路由表ID
  route_table_id = alicloud_vpc.vpc.route_table_id
  # 目标网段，自定义
  destination_cidrblock = "1.2.3.4/32"
  # 下一跳类型
  nexthop_type = "VpcPeer"
  # 下一跳id
  nexthop_id = alicloud_vpc_peer_connection.default.id
}
# 配置路由条目2 -vpc-B
resource "alicloud_route_entry" "foo1" {
  # VPC-A 路由表id
  route_table_id = alicloud_vpc.vpc1.route_table_id
  # 目标网段，自定义
  destination_cidrblock = "4.3.2.1/32"
  # 下一跳类型
  nexthop_type = "VpcPeer"
  # 下一跳id
  nexthop_id = alicloud_vpc_peer_connection.default.id
}
# 先创建其他前置资源
resource "time_sleep" "wait_before_firewall" {
  # 确保云企业网实例，网络连接实例创建好后
  depends_on = [
    alicloud_route_entry.foo,
    alicloud_route_entry.foo1
  ]
  create_duration = "720s" # 根据需要设置时间
}
# 延迟
resource "null_resource" "wait_for_firewall" {
  provisioner "local-exec" {
    command = "echo waiting for firewall to be ready"
  }
  # 确保云企业网实例创建
  depends_on = [time_sleep.wait_before_firewall]
}
# VPC对等连接高速通道防火墙实例
resource "alicloud_cloud_firewall_vpc_firewall" "default" {
  # 前置依赖
  depends_on = [
    null_resource.wait_for_firewall
  ]
  timeouts {
    create = "30m" # 给创建加上超时时间
  }
  # 实例名称
  vpc_firewall_name = "tf-test"
  # 用户uid
  member_uid = data.alicloud_account.current.id
  local_vpc {
    # 发起端vpc id
    vpc_id = alicloud_vpc.vpc.id
    # 地域
    region_no = "cn-heyuan"
    # 路由条目
    local_vpc_cidr_table_list {
      # 路由表id
      local_route_table_id = alicloud_vpc.vpc.route_table_id
      local_route_entry_list {
        # 下一跳
        local_next_hop_instance_id = alicloud_vpc_peer_connection.default.id
        # 目标网块
        local_destination_cidr = alicloud_route_entry.foo.destination_cidrblock
      }
    }
  }
  peer_vpc {
    # 接收端vpc id
    vpc_id = alicloud_vpc.vpc1.id
    # 地域
    region_no = "cn-heyuan"
    # 路由条目
    peer_vpc_cidr_table_list {
      # 路由表id
      peer_route_table_id = alicloud_vpc.vpc1.route_table_id
      peer_route_entry_list {
        # 目标网块
        peer_destination_cidr = alicloud_route_entry.foo1.destination_cidrblock
        # 下一跳
        peer_next_hop_instance_id = alicloud_vpc_peer_connection.default.id
      }
    }
  }
  # 资源的状态。有效值：
  # open: 创建 VPC 边界防火墙后，保护机制自动启用。
  # close: 创建 VPC 边界防火墙后，不自动启用保护。
  status = "open"
}
resource "alicloud_cloud_firewall_vpc_firewall_control_policy" "default" {
  # 访问控制策略的优先级。优先级值从 1 开始，较小的优先级值表示更高的优先级。
  order = "1"
  # 访问控制策略中的目的地址。
  destination = "0.0.0.0/0"
  # 访问控制策略支持的应用类型。
  application_name = "ANY"
  # VPC 防火墙访问控制策略的信息描述。
  description = "Created_by_Terraform"
  # 访问控制策略中的源地址类型。有效值：net，group。
  source_type = "net"
  # （可选）访问控制策略中的目的端口。
  dest_port = "80/88"
  # 云防火墙在流量上执行的操作。有效值：accept，drop，log。
  acl_action = "accept"
  # 请求和响应内容的语言。有效值：zh，en。
  lang = "zh"
  # net，则 destination 的值必须是一个 CIDR 块。
  destination_type = "net"
  # VPC 防火墙访问控制策略中的源地址。
  source = "0.0.0.0/0"
  # 访问控制策略中的目的端口类型。有效值：port，group。
  dest_port_type = "port"
  # 访问控制策略中的协议类型。有效值：ANY，TCP，UDP，ICMP。
  proto = "TCP"
  # 访问控制策略的启用状态。默认情况下，策略创建后会启用。
  release = true
  # 当前阿里云账户的uid
  member_uid = data.alicloud_account.current.id
  # VPC 防火墙实例的 ID
  vpc_firewall_id = alicloud_cloud_firewall_vpc_firewall.default.id
}