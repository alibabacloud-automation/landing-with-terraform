data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7"
}

data "alicloud_zones" "default" {
  available_instance_type = data.alicloud_instance_types.default.ids.0
}

data "alicloud_alb_zones" "default" {}

data "alicloud_images" "instance_image" {
  name_regex  = "^aliyun_3_9_x64_20G_*"
  most_recent = true
  owners      = "system"
}

# 创建VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.common_name
  cidr_block = "192.168.0.0/16"
}

# 创建VSwitch1
resource "alicloud_vswitch" "ecs_vswitch_1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_zones.default.ids.0
  vswitch_name = "${var.common_name}-vsw"
}

# 创建VSwitch2
resource "alicloud_vswitch" "ecs_vswitch_2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.2.0/24"
  zone_id      = data.alicloud_zones.default.ids.1
  vswitch_name = "${var.common_name}-vsw"
}

# 创建VSwitch3
resource "alicloud_vswitch" "alb_vswitch_3" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.3.0/24"
  zone_id      = data.alicloud_alb_zones.default.ids.0
  vswitch_name = "${var.common_name}-vsw"
}

# 创建VSwitch4
resource "alicloud_vswitch" "alb_vswitch_4" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.4.0/24"
  zone_id      = data.alicloud_alb_zones.default.ids.1
  vswitch_name = "${var.common_name}-vsw"
}

# 创建安全组
resource "alicloud_security_group" "security_group" {
  security_group_name = "${var.common_name}-sg"
  vpc_id              = alicloud_vpc.vpc.id
}

# 添加安全组规则 - HTTP
resource "alicloud_security_group_rule" "security_group_http" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "192.168.0.0/16"
}

# 添加安全组规则 - HTTPS
resource "alicloud_security_group_rule" "security_group_https" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  cidr_ip           = "192.168.0.0/16"
}

# 创建ALB负载均衡器
resource "alicloud_alb_load_balancer" "alb" {
  load_balancer_name     = "${var.common_name}-alb"
  load_balancer_edition  = "Basic"
  address_allocated_mode = "Fixed"
  vpc_id                 = alicloud_vpc.vpc.id
  address_type           = "Internet"

  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }

  zone_mappings {
    zone_id    = data.alicloud_alb_zones.default.ids.0
    vswitch_id = alicloud_vswitch.alb_vswitch_3.id
  }

  zone_mappings {
    zone_id    = data.alicloud_alb_zones.default.ids.1
    vswitch_id = alicloud_vswitch.alb_vswitch_4.id
  }
}

# 创建ALB服务器组
resource "alicloud_alb_server_group" "alb_server_group" {
  server_group_name = "${var.common_name}-server-group"
  vpc_id            = alicloud_vpc.vpc.id
  protocol          = "HTTP"

  health_check_config {
    health_check_enabled      = true
    health_check_protocol     = "HTTP"
    health_check_path         = "/"
    health_check_codes        = ["http_2xx", "http_3xx"]
    health_check_connect_port = 80
  }

  sticky_session_config {
    sticky_session_enabled = false
  }

  lifecycle {
    ignore_changes = [servers]
  }
}

# 创建ALB监听器
resource "alicloud_alb_listener" "alb_listener" {
  listener_protocol = "HTTP"
  listener_port     = 80
  load_balancer_id  = alicloud_alb_load_balancer.alb.id

  default_actions {
    type = "ForwardGroup"
    forward_group_config {
      server_group_tuples {
        server_group_id = alicloud_alb_server_group.alb_server_group.id
      }
    }
  }
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 创建ESS伸缩组，min_size设置为2，在伸缩组启用后，会自动创建两台ECS实例
resource "alicloud_ess_scaling_group" "ess_scaling_group" {
  scaling_group_name = "${var.common_name}-scaling-group-${random_integer.default.result}"
  min_size           = 2
  max_size           = 5
  vswitch_ids        = [alicloud_vswitch.ecs_vswitch_1.id, alicloud_vswitch.ecs_vswitch_2.id]
  removal_policies   = ["NewestInstance"]
  default_cooldown   = 300
  multi_az_policy    = "COMPOSABLE"
  az_balance         = true
  depends_on         = [alicloud_security_group.security_group]
}

# 配置ESS服务器组关联
resource "alicloud_ess_server_group_attachment" "ess_server_group" {
  scaling_group_id = alicloud_ess_scaling_group.ess_scaling_group.id
  server_group_id  = alicloud_alb_server_group.alb_server_group.id
  port             = 80
  type             = "ALB"
  weight           = 100
  force_attach     = true
}

locals {
  instance_user_data = <<-SHELL
  #!/bin/bash
  yum -y install nginx-1.20.1
  instanceId=`curl http://100.100.100.200/latest/meta-data/instance-id`
  echo "This instance from ess, the instance id is $instanceId" > /usr/share/nginx/html/index.html
  systemctl start nginx
  systemctl enable nginx
  SHELL
}

# 创建ESS伸缩配置
resource "alicloud_ess_scaling_configuration" "ess_scaling_configuration" {
  scaling_group_id     = alicloud_ess_scaling_group.ess_scaling_group.id
  enable               = true
  active               = true
  force_delete         = true
  image_id             = data.alicloud_images.instance_image.images[0].id
  instance_types       = [data.alicloud_instance_types.default.ids.0]
  security_group_id    = alicloud_security_group.security_group.id
  system_disk_category = "cloud_essd"
  system_disk_size     = 40
  password             = var.ecs_instance_password
  instance_name        = "${var.common_name}-ess"
  user_data            = local.instance_user_data
}

# 创建ESS伸缩规则（扩容）
resource "alicloud_ess_scaling_rule" "ess_scale_up_rule" {
  scaling_group_id  = alicloud_ess_scaling_group.ess_scaling_group.id
  scaling_rule_name = "${var.common_name}-asr-scale_up_rule"
  scaling_rule_type = "SimpleScalingRule"
  adjustment_type   = "QuantityChangeInCapacity"
  adjustment_value  = 1
  cooldown          = 60
}

# 创建ESS伸缩规则（缩容）
resource "alicloud_ess_scaling_rule" "ess_scale_down_rule" {
  scaling_group_id  = alicloud_ess_scaling_group.ess_scaling_group.id
  scaling_rule_name = "${var.common_name}-asr-scale_down_rule"
  scaling_rule_type = "SimpleScalingRule"
  adjustment_type   = "QuantityChangeInCapacity"
  adjustment_value  = -1
  cooldown          = 60
}

resource "time_static" "example" {}

# 创建定时任务（自动扩容）
resource "alicloud_ess_scheduled_task" "scheduled_scale_up_task" {
  scheduled_task_name    = "${var.common_name}-scale_up_task-${random_integer.default.result}"
  launch_time            = var.scale_up_time != null && var.scale_up_time != "" ? var.scale_up_time : format("%sZ", substr(timeadd(time_static.example.rfc3339, "1h"), 0, 16))
  scheduled_action       = alicloud_ess_scaling_rule.ess_scale_up_rule.ari
  launch_expiration_time = 10
}

# 创建定时任务（自动缩容）
resource "alicloud_ess_scheduled_task" "scheduled_scale_down_task" {
  scheduled_task_name    = "${var.common_name}-scale_down_task-${random_integer.default.result}"
  launch_time            = var.scale_down_time != null && var.scale_down_time != "" ? var.scale_down_time : format("%sZ", substr(timeadd(time_static.example.rfc3339, "2h"), 0, 16))
  scheduled_action       = alicloud_ess_scaling_rule.ess_scale_down_rule.ari
  launch_expiration_time = 10
}

