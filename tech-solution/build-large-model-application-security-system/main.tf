provider "alicloud" {
  region = var.region
}

resource "random_id" "suffix" {
  byte_length = 8
}

locals {
  common_name = random_id.suffix.id
}

data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_x64_20G_alibase_.*"
  most_recent = true
  owners      = "system"
}

resource "alicloud_ram_user" "ram_user" {
  name = "create_by_solution-${local.common_name}"
}

resource "alicloud_ram_access_key" "ramak" {
  user_name = alicloud_ram_user.ram_user.name
}

resource "alicloud_ram_user_policy_attachment" "attach_policy_to_user" {
  user_name   = alicloud_ram_user.ram_user.name
  policy_type = "System"
  policy_name = "AliyunYundunGreenWebFullAccess"
}

resource "alicloud_security_group" "security_group" {
  security_group_name = "SG_${local.common_name}"
  vpc_id              = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_tcp_80" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_vswitch" "vswitch1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = var.zone_id1
  vswitch_name = "VSW_${local.common_name}"
}

resource "alicloud_instance" "ecs_instance" {
  instance_name              = "ecs-${local.common_name}"
  system_disk_category       = "cloud_essd"
  image_id                   = data.alicloud_images.default.images[0].id
  vswitch_id                 = alicloud_vswitch.vswitch1.id
  password                   = var.ecs_instance_password
  instance_type              = var.instance_type
  internet_max_bandwidth_out = 5
  security_groups            = [alicloud_security_group.security_group.id]
}

resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "VPC_${local.common_name}"
}

resource "alicloud_ecs_command" "run_command" {
  name = "commond-install"
  command_content = base64encode(<<EOF
cat <<EOT >> ~/.bash_profile
export ROS_DEPLOY=true
export BAILIAN_API_KEY=${var.bai_lian_api_key}
export ALIBABA_CLOUD_ACCESS_KEY_ID=${alicloud_ram_access_key.ramak.id}
export ALIBABA_CLOUD_ACCESS_KEY_SECRET=${alicloud_ram_access_key.ramak.secret}
EOT

source ~/.bash_profile
curl -fsSL https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/install-script/ai-security/install.sh | bash
EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
}

resource "alicloud_ecs_invocation" "invoke_script" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.run_command.id
  timeouts {
    create = "15m"
  }
}
