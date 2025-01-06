variable "region" {
  default     = "us-west-1"
  type        = string
  description = "The region where the load balancing instance is located"
}

# 是否创建负载均衡
variable "create_slb" {
  default     = "true"
  type        = bool
  description = "Do you want to create slb load balancer"
}

# 已有负载均衡实例
variable "alicloud_slb_load_balancer_id" {
  default     = ""
  type        = string
  description = "SLB instance ID"
}

provider "alicloud" {
  region = var.region
}

data "alicloud_slb_load_balancers" "exist_slb" {
  ids = [var.alicloud_slb_load_balancer_id]
}

# 可用区
data "alicloud_zones" "example" {
  available_resource_creation      = "VSwitch"
  available_disk_category          = "cloud_essd"
  available_instance_type          = "ecs.e-c1m1.large"
  available_slb_address_ip_version = "ipv4"
  available_slb_address_type       = "classic_internet"
}

locals {
  # ECS中部署服务脚本
  ecs_command = <<EOS
    yum install -y nginx
    systemctl start nginx.service
    cd /usr/share/nginx/html/
    echo "Hello World ! This is  ECS." > index.html
    EOS
}

# 随机数，取值${random_integer.example.result}
resource "random_integer" "example" {
  min = 10000
  max = 99999
}

# 专有网络VPC
resource "alicloud_vpc" "example" {
  count      = var.create_slb ? 1 : 0
  vpc_name   = "vpc_name_${random_integer.example.result}"
  cidr_block = "172.16.0.0/16"
}

# 交换机
resource "alicloud_vswitch" "vswitch" {
  count        = var.create_slb ? 1 : 0
  vpc_id       = alicloud_vpc.example.0.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_zones.example.zones[0].id
  vswitch_name = "vswitch_name_${random_integer.example.result}"
}

# 安全组
resource "alicloud_security_group" "example" {
  count               = var.create_slb ? 1 : 0
  security_group_name = "security_group_name_${random_integer.example.result}"
  vpc_id              = alicloud_vpc.example.0.id
}

# 添加允许TCP 80端口入方向流量的规则
resource "alicloud_security_group_rule" "ingress" {
  count             = var.create_slb ? 1 : 0
  type              = "ingress"                            # 入方向规则
  ip_protocol       = "tcp"                                # TCP协议
  nic_type          = "intranet"                           # 内网网卡类型（VPC环境）
  policy            = "accept"                             # 允许策略
  port_range        = "80/80"                              # 允许80端口
  priority          = 1                                    # 优先级设置
  security_group_id = alicloud_security_group.example.0.id # 关联的安全组ID
  cidr_ip           = "10.0.0.0/8"                         # 允许的IP地址范围，示例为10.0.0.0/8
}

# 添加允许TCP 80端口出方向流量的规则
resource "alicloud_security_group_rule" "egress" {
  count             = var.create_slb ? 1 : 0
  type              = "egress"                             # 入方向规则
  ip_protocol       = "tcp"                                # TCP协议
  nic_type          = "intranet"                           # 内网网卡类型（VPC环境）
  policy            = "accept"                             # 允许策略
  port_range        = "8/80"                               # 允许80端口
  priority          = 1                                    # 优先级设置
  security_group_id = alicloud_security_group.example.0.id # 关联的安全组ID
  cidr_ip           = "10.0.0.0/8"                         # 允许的IP地址范围，示例为10.0.0.0/8
}

# ECS实例
resource "alicloud_instance" "example" {
  count                      = var.create_slb ? 1 : 0
  availability_zone          = data.alicloud_zones.example.zones[0].id
  security_groups            = alicloud_security_group.example.*.id
  instance_type              = "ecs.e-c1m1.large"
  system_disk_category       = "cloud_essd"
  system_disk_name           = "system_disk_name_${random_integer.example.result}"
  system_disk_description    = "system_disk_description_${random_integer.example.result}"
  image_id                   = "aliyun_2_1903_x64_20G_alibase_20240628.vhd"
  instance_name              = "instance_name_${random_integer.example.result}"
  vswitch_id                 = alicloud_vswitch.vswitch.0.id
  internet_max_bandwidth_out = 10
  password                   = "Terraform@Example"
}

# ECS命令
resource "alicloud_ecs_command" "ecs_command" {
  name             = "ecs_command_name"
  description      = "ecs_command_description"
  enable_parameter = false
  type             = "RunShellScript"
  command_content  = base64encode(local.ecs_command)
  timeout          = 3600
  working_dir      = "/root"
  lifecycle {
    ignore_changes = [command_content]
  }
}

# 在ECS中执行命令
resource "alicloud_ecs_invocation" "invocation" {
  instance_id = [alicloud_instance.example.0.id]
  command_id  = alicloud_ecs_command.ecs_command.id
  timeouts {
    create = "5m"
  }
}

# clb 实例
resource "alicloud_slb_load_balancer" "example" {
  count                = var.create_slb ? 1 : 0
  load_balancer_name   = "load_balancer_name_${random_integer.example.result}"
  load_balancer_spec   = "slb.s2.small"
  address_type         = "intranet"
  address_ip_version   = "ipv4"
  vswitch_id           = alicloud_vswitch.vswitch.0.id
  instance_charge_type = "PayBySpec"
}

# 创建clb后需初始化，一般不超过60S
resource "time_sleep" "example" {
  depends_on      = [alicloud_slb_load_balancer.example]
  create_duration = "60s"
}

# clb 服务器组
resource "alicloud_slb_server_group" "example" {
  depends_on       = [time_sleep.example]
  count            = var.create_slb ? 1 : 0
  load_balancer_id = alicloud_slb_load_balancer.example.0.id
  name             = "slb_server_group_name_${random_integer.example.result}"
}

# 服务器组添加 ECS
resource "alicloud_slb_server_group_server_attachment" "example" {
  count           = var.create_slb ? 1 : 0
  server_group_id = alicloud_slb_server_group.example.0.id
  server_id       = alicloud_instance.example.0.id
  port            = 80
  weight          = 100
  type            = "ecs"
}

# clb监听
resource "alicloud_slb_listener" "example" {
  count            = var.create_slb ? 1 : 0
  description      = "description_${random_integer.example.result}"
  load_balancer_id = alicloud_slb_load_balancer.example.0.id
  server_group_id  = alicloud_slb_server_group.example.0.id
  backend_port     = 80
  frontend_port    = 80
  protocol         = "http"
  bandwidth        = 10
}

resource "null_resource" "check" {
  count = var.create_slb ? 0 : 1
  # 前置条件，clb的网络类型必须为intranet
  lifecycle {
    precondition {
      condition     = length([data.alicloud_slb_load_balancers.exist_slb.balancers]) > "0"
      error_message = "The slb ${var.alicloud_slb_load_balancer_id}  is not exist"
    }
    precondition {
      condition     = data.alicloud_slb_load_balancers.exist_slb.balancers[0].address_type == "intranet"
      error_message = "The address_type of slb ${var.alicloud_slb_load_balancer_id} must be intranet"
    }
  }
}

# Anycast EIP实例
resource "alicloud_eipanycast_anycast_eip_address" "example" {
  anycast_eip_address_name = "anycast_eip_address_name_${random_integer.example.result}"
  description              = "description_${random_integer.example.result}"
  bandwidth                = 200
  service_location         = "international"
  internet_charge_type     = "PayByTraffic"
  payment_type             = "PayAsYouGo"
}

# Anycast EIP实例绑定资源
resource "alicloud_eipanycast_anycast_eip_address_attachment" "example" {
  bind_instance_id        = var.create_slb ? alicloud_slb_load_balancer.example.0.id : var.alicloud_slb_load_balancer_id
  bind_instance_type      = "SlbInstance"
  bind_instance_region_id = var.region
  anycast_id              = alicloud_eipanycast_anycast_eip_address.example.id
  depends_on              = [null_resource.check]
}
