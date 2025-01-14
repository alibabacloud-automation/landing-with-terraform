// 统一公网出口IP
variable "region" {
  default = "cn-beijing"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "nat-test-ip"
}
variable "password" {
  default = "Test123@"
}
// 查询ECS镜像
data "alicloud_images" "default" {
  most_recent = true
  owners      = "system"
}
// 查询ECS类型
data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones.0.id
  image_id          = data.alicloud_images.default.images.0.id
}
// 查询可用区
data "alicloud_zones" "default" {
}
variable "master_zone" {
  default = "cn-beijing-h"
}
variable "image_id" {
  default = "aliyun_3_x64_20G_alibase_20241103.vhd"
}
variable "load_balancer_spec" {
  default = "slb.s2.small"
}
variable "instance_type" {
  default = "ecs.e-c1m2.xlarge"
}
locals {
  // ECS_A 中部署服务脚本 ip -4 route add default via “eth1子网网关” dev eth1 table “路由表名称”   ip -4 rule add from “eth1网卡地址” lookup “路由表名称”   启用内部转发 echo "1" > /proc/sys/net/ipv4/ip_forward
  ecs_a_command = <<EOS
    ip -4 route add default via 172.16.20.253  dev eth1 table 101
    ip -4 rule add from ${alicloud_network_interface.eni_a.private_ip} lookup 101
    echo "ip -4 route add default via 172.16.20.253 dev eth1 table 101" >> /etc/rc.local,
    echo "ip -4 rule add from ${alicloud_network_interface.eni_a.private_ip} lookup 101" >> /etc/rc.local,
    sudo chmod +x /etc/rc.local
    echo "1" > /proc/sys/net/ipv4/ip_forward
    EOS
  // ECS_B ECS_C 安装nginx，监听 80 端口
  ecs_b_command = <<EOS
    sudo yum update -y
    sudo yum install nginx -y
    sudo systemctl start nginx
    sudo netstat -tuln | grep :80
    sudo iptables -L
    sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
    echo "Hello World ! This is ECS_B." > /usr/share/nginx/html/index.html
    sudo systemctl restart nginx
    EOS
  ecs_c_command = <<EOS
    sudo yum update -y
    sudo yum install nginx -y
    sudo systemctl start nginx
    sudo netstat -tuln | grep :80
    sudo iptables -L
    sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
    echo "Hello World ! This is ECS_C." > /usr/share/nginx/html/index.html
    sudo systemctl restart nginx
    EOS
}
// 查询ECS实例
data "alicloud_instances" "ecs_instance" {
  ids = [alicloud_instance.a.id]
}
// 前置资源准备 VPC Vsw ECS
resource "alicloud_vpc" "a" {
  vpc_name   = "VPC_A"
  cidr_block = "172.16.0.0/12"
}
resource "alicloud_vswitch" "a1" {
  vpc_id       = alicloud_vpc.a.id
  cidr_block   = "172.16.20.0/24"
  zone_id      = var.master_zone
  vswitch_name = "VS_A1"
}
resource "alicloud_security_group" "a" {
  security_group_name = var.name
  vpc_id              = alicloud_vpc.a.id
}
// 安全组 VPC_A 规则
resource "alicloud_security_group_rule" "a" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.a.id
  cidr_ip           = "0.0.0.0/0"
}
// ECS实例 A、B、C
resource "alicloud_instance" "a" {
  # 实例镜像
  image_id = var.image_id
  # 启动类型
  instance_type = var.instance_type
  # 安全组
  security_groups = alicloud_security_group.a.*.id
  # 实例的互联网收费类型
  internet_charge_type = "PayByTraffic"
  # 向公共网络的最大出站带宽，以 Mbps（兆位每秒）为单位。值范围：[0，100]。 0不创建公网IP
  internet_max_bandwidth_out = "0"
  # 启动实例的可用区
  // availability_zone          = data.alicloud_instance_types.default.instance_types.0.availability_zones.0
  availability_zone = var.master_zone
  # 有效值为 PrePaid、PostPaid，默认值为 PostPaid。
  instance_charge_type = "PostPaid"
  # 仅对一些非 I/O 优化实例使用。
  system_disk_category = "cloud_essd"
  # 交换机id
  vswitch_id = alicloud_vswitch.a1.id
  # 实例名称
  instance_name = "ECS_A"
  # vpc-A ID
  vpc_id = alicloud_vpc.a.id
  # 密码
  password = var.password
}
resource "alicloud_instance" "b" {
  # 实例镜像
  image_id = var.image_id
  # 启动类型
  instance_type = data.alicloud_instance_types.default.instance_types.0.id
  # 安全组
  security_groups = alicloud_security_group.a.*.id
  # 实例的互联网收费类型
  internet_charge_type = "PayByTraffic"
  # 向公共网络的最大出站带宽，以 Mbps（兆位每秒）为单位。值范围：[0，100]。 0不创建公网IP
  internet_max_bandwidth_out = "0"
  # 启动实例的可用区
  // availability_zone          = data.alicloud_instance_types.default.instance_types.0.availability_zones.0
  availability_zone = var.master_zone
  # 有效值为 PrePaid、PostPaid，默认值为 PostPaid。
  instance_charge_type = "PostPaid"
  # 仅对一些非 I/O 优化实例使用。
  system_disk_category = "cloud_efficiency"
  # 交换机id
  vswitch_id = alicloud_vswitch.a1.id
  # 实例名称
  instance_name = "ECS_B"
  # vpc-A ID
  vpc_id = alicloud_vpc.a.id
  # 密码
  password = var.password
}
resource "alicloud_instance" "c" {
  # 实例镜像
  image_id = var.image_id
  # 启动类型
  instance_type = data.alicloud_instance_types.default.instance_types.0.id
  # 安全组
  security_groups = alicloud_security_group.a.*.id
  # 实例的互联网收费类型
  internet_charge_type = "PayByTraffic"
  # 向公共网络的最大出站带宽，以 Mbps（兆位每秒）为单位。值范围：[0，100]。 0不创建公网IP
  internet_max_bandwidth_out = "0"
  # 启动实例的可用区
  // availability_zone          = data.alicloud_instance_types.default.instance_types.0.availability_zones.0
  availability_zone = var.master_zone
  # 有效值为 PrePaid、PostPaid，默认值为 PostPaid。
  instance_charge_type = "PostPaid"
  # 仅对一些非 I/O 优化实例使用。
  system_disk_category = "cloud_efficiency"
  # 交换机id
  vswitch_id = alicloud_vswitch.a1.id
  # 实例名称
  instance_name = "ECS_C"
  # vpc-A ID
  vpc_id = alicloud_vpc.a.id
  # 密码
  password = var.password
}
// 1.创建EIP 绑定弹性网卡（绑定ECS_A）
resource "alicloud_eip_address" "aa" {
  description  = var.name
  isp          = "BGP"
  address_name = "ECS_A_EIP"
  # 网络类型。默认值为public，表示公用网络类型。
  netmode = "public"
  # 弹性公共网络的最大带宽
  bandwidth = "1"
  # EIP的计费方式。有效值：Subscription和PayAsYouGo
  payment_type = "PayAsYouGo"
  # 是否启用删除保护。默认值：false。
  deletion_protection = false
}
// 2.创建弹性网卡，绑定ECS_A
resource "alicloud_network_interface" "eni_a" {
  network_interface_name = "eni-a"
  vswitch_id             = alicloud_vswitch.a1.id
  security_group_ids     = [alicloud_security_group.a.id]
  description            = "Network Interface for ECS A"
}
// 将弹性网卡（ENI）绑定到ECS_A
resource "alicloud_network_interface_attachment" "attach_to_ecs_a" {
  instance_id          = alicloud_instance.a.id
  network_interface_id = alicloud_network_interface.eni_a.id
}
// 4. 将 EIP 绑定至 ECS-A 的弹性网卡上（ETH1）
resource "alicloud_eip_association" "eip_association" {
  allocation_id = alicloud_eip_address.aa.id
  # 绑定在弹性网卡上
  instance_id = alicloud_network_interface.eni_a.id
  # ECS_A的私有IP
  # private_ip_address = alicloud_instance.a.private_ip
  instance_type = "NetworkInterface"
}
// ECS_A 中配置路由策略 1.ip -4 route add default via “eth1子网网关” dev eth1 table “路由表名称” ; ip -4 rule add from “eth1网卡地址” lookup “路由表名称”  2. 启用内部转发 echo "1" > /proc/sys/net/ipv4/ip_forward
// ECS_A 创建命令
resource "alicloud_ecs_command" "ecs_a" {
  name            = "ecs_a"
  command_content = base64encode(local.ecs_a_command) # Base64 编码的命令内容
  description     = "ECS_A command"                   # 命令描述
  type            = "RunShellScript"                  # 命令类型
  working_dir     = "/root"                           # 命令执行的工作目录
  timeout         = 3600
}
// ECS_A 执行命令
resource "alicloud_ecs_invocation" "ecs_a" {
  command_id  = alicloud_ecs_command.ecs_a.id
  instance_id = [alicloud_instance.a.id]
  timeouts {
    create = "10m"
  }
}
// ECS_B ECS_C 安装nginx,监听 80 端口
// ECS_B 创建命令
resource "alicloud_ecs_command" "ecs_b" {
  name            = "ecs_b"
  command_content = base64encode(local.ecs_b_command) # Base64 编码的命令内容
  description     = "ECS_B command"                   # 命令描述
  type            = "RunShellScript"                  # 命令类型
  working_dir     = "/root"                           # 命令执行的工作目录
  timeout         = 3600
}
// ECS_B 执行命令
resource "alicloud_ecs_invocation" "ecs_b" {
  command_id  = alicloud_ecs_command.ecs_b.id
  instance_id = [alicloud_instance.b.id]
  timeouts {
    create = "10m"
  }
}
// ECS_C 创建命令
resource "alicloud_ecs_command" "ecs_c" {
  name            = "ecs_b"
  command_content = base64encode(local.ecs_c_command) # Base64 编码的命令内容
  description     = "ECS_B command"                   # 命令描述
  type            = "RunShellScript"                  # 命令类型
  working_dir     = "/root"                           # 命令执行的工作目录
  timeout         = 3600
}
// ECS_C 执行命令
resource "alicloud_ecs_invocation" "ecs_c" {
  command_id  = alicloud_ecs_command.ecs_c.id
  instance_id = [alicloud_instance.c.id]
  timeouts {
    create = "10m"
  }
}
// 步骤二：创建 NAT EIP 绑定 NAT网关的 SNAT 条目
resource "alicloud_eip_address" "a" {
  description  = var.name
  isp          = "BGP"
  address_name = var.name
  # 网络类型。默认值为public，表示公用网络类型。
  netmode = "public"
  # 弹性公共网络的最大带宽
  bandwidth = "1"
  # EIP的计费方式。有效值：Subscription和PayAsYouGo
  payment_type = "PayAsYouGo"
  # 是否启用删除保护。默认值：false。
  deletion_protection = false
}
// 步骤三：EIP 绑定到 公网NAT网关，设置 SNAT 条目
// 创建公网 NAT 网关
resource "alicloud_nat_gateway" "default" {
  vpc_id           = alicloud_vpc.a.id
  nat_gateway_name = var.name
  vswitch_id       = alicloud_vswitch.a1.id
  # 增强型
  nat_type = "Enhanced"
  # 是否强制删除
  force = true
  # 计费类型
  payment_type = "PayAsYouGo"
  # 网关类型 internet和intranet。internet: 互联网NAT网关。intranet: VPC NAT网关。
  network_type = "internet"
  # 是否启用删除保护。默认值：false。
  deletion_protection = false
}
// eip 绑定到NAT网关
resource "alicloud_eip_association" "b" {
  # EIP实例的ID。
  allocation_id = alicloud_eip_address.a.id
  # NAT ID
  instance_id = alicloud_nat_gateway.default.id
  # 绑定的 NAT 实例类型
  instance_type = "Nat"
}
// 为 VPC_A 在 公网NAT 实例中配置 SNAT 条目  a1交换机
resource "alicloud_snat_entry" "default" {
  snat_entry_name = var.name
  # 该值可以从alicloud_nat_gateway的属性"snat_table_ids"获取。
  snat_table_id = alicloud_nat_gateway.default.snat_table_ids
  # 绑定交换机 a1
  source_vswitch_id = alicloud_vswitch.a1.id
  # SNAT的IP地址，IP必须与alicloud_nat_gateway参数bandwidth_packages中的带宽包公共IP一致。公网NAT 网关的 EIP
  snat_ip = alicloud_eip_address.a.ip_address
}
// 设置公网NAT网关的 DNAT 条目和 SLB 绑定
// 创建SLB-CLB实例
// SLB-CLB 实例
resource "alicloud_slb_load_balancer" "load_balancer" {
  # 名称
  load_balancer_name = var.name
  # 类型
  address_type = "intranet"
  # 规格
  load_balancer_spec = var.load_balancer_spec
  vswitch_id         = alicloud_vswitch.a1.id
  tags = {
    info = "create for internet"
  }
  # 计费类型
  instance_charge_type = "PayBySpec"
}
// SLB-CLB监听
resource "alicloud_slb_listener" "listener" {
  # 负载均衡实例ID
  load_balancer_id = alicloud_slb_load_balancer.load_balancer.id
  # 后端端口
  backend_port = 80
  # 前端端口
  frontend_port = 80
  # 要使用的协议。有效值：http。
  protocol = "http"
  # 监听器的最大带宽。单位：Mbit/s。有效值：
  # -1：如果将带宽设置为-1，则监听器的带宽无限制。
  # 1到1000：为CLB实例的所有监听器指定的最大带宽之和不得超过CLB实例的最大带宽。
  bandwidth = 10
}
// SLB-CLB 后端服务器
resource "alicloud_slb_backend_server" "backend_server" {
  # SLB-CLB ID
  load_balancer_id = alicloud_slb_load_balancer.load_balancer.id
  # 后端服务 ECS 要添加到 SLB 的后端服务器实例列表。它包含以下三个子字段作为块服务器。
  backend_servers {
    # 后端服务器
    server_id = alicloud_instance.b.id
    # 后端服务器的权重。有效值范围：[0-100]。
    weight = 50
    # 服务器类型
    type = "ecs"
  }
  backend_servers {
    # 后端服务器
    server_id = alicloud_instance.c.id
    # 后端服务器的权重。有效值范围：[0-100]。
    weight = 50
    # 服务器类型
    type = "ecs"
  }
}
// 设置 DNAT 条目  SLB-CLB
resource "alicloud_forward_entry" "default" {
  # 该值可以从alicloud_nat_gateway的属性"forward_table_ids"获取
  forward_table_id = alicloud_nat_gateway.default.forward_table_ids
  # 外部IP地址，必须与alicloud_nat_gateway参数中的带宽包公共IP一致。  EIP
  external_ip = alicloud_eip_address.a.ip_address
  # 外部端口，有效值为1~65535或其他。
  external_port = "80"
  # IP协议，有效值为tcp、udp或其他。
  ip_protocol = "tcp"
  # 内部IP，必须是私有IP。 CLB的 VPC地址
  internal_ip = alicloud_slb_load_balancer.load_balancer.address
  # 内部端口，有效值为1~65535或其他。
  internal_port = "80"
}
// vpc vsw
output "alicloud_vpc" {
  value = alicloud_vpc.a.id
}
output "alicloud_vswitch" {
  value = alicloud_vswitch.a1.id
}
// 输出负载均衡的 VPC 地址
output "slb_load_balancer_address" {
  description = "The address of the created CLB instance"
  value       = alicloud_slb_load_balancer.load_balancer.address
}
// 输出 弹性公网 的 IP
output "alicloud_eip_address_nat" {
  value = alicloud_eip_address.a.ip_address
}
// 输出 弹性公网 ECS_A 的IP
output "alicloud_eip_address_ecs_a" {
  value = alicloud_eip_address.aa.ip_address
}
// 输出 ECS_A 弹性网卡的 Ip
output "eni_ecs_a" {
  value = alicloud_network_interface.eni_a.private_ip
}