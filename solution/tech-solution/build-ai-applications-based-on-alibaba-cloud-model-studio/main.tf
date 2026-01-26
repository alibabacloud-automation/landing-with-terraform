provider "alicloud" {
  region = var.region
}

// VPC Resource
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "${var.common_name}-VPC"
}

// VSwitch Resource
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = var.zone_id
  vswitch_name = "${var.common_name}-vsw_001"
}

// Security Group Resource
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "${var.common_name}-SecurityGroup_1"
}

// Security Group Rule for HTTP access
resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "192.168.0.0/24"
}

// ECS Instance Resource
resource "alicloud_instance" "ecs_instance" {
  vpc_id                     = alicloud_vpc.vpc.id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  security_groups            = [alicloud_security_group.security_group.id]
  image_id                   = "aliyun_3_9_x64_20G_alibase_20231219.vhd"
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  system_disk_size           = 40
  internet_max_bandwidth_out = 5
  password                   = var.ecs_instance_password
}

// Run Command on ECS Instance
resource "alicloud_ecs_command" "run_script" {
  name = "setup-bailian-app"
  command_content = base64encode(<<SCRIPT
#!/bin/bash
cat << "PROFILE_EOF" >> ~/.bash_profile
export BAILIAN_API_KEY=${var.bai_lian_api_key}
export ROS_DEPLOY=true
PROFILE_EOF

source ~/.bash_profile

curl -fsSL https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/install-script/create-ai-app-via-bailian/install.sh | bash
SCRIPT
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
}

resource "alicloud_ecs_invocation" "run_command" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.run_script.id
  timeouts {
    create = "15m"
  }
} 