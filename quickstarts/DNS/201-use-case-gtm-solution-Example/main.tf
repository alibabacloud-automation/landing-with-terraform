variable "region" {
  default = "cn-hangzhou"
}

variable "password" {
  default     = "Test@12345<>"
  description = "The password for the ECS instance must be 8 to 30 characters in length and must include at least three of the following character types: uppercase letters, lowercase letters, numbers, and special symbols."
}

variable "instance_type" {
  default = "ecs.e-c1m1.large"
}

provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc01"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "vsw" {
  vswitch_name = "vsw01"
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  security_group_name = "sg01"
  vpc_id              = alicloud_vpc.vpc.id
}

resource "alicloud_instance" "instance" {
  availability_zone          = data.alicloud_zones.default.zones.0.id
  security_groups            = alicloud_security_group.default.*.id
  password                   = var.password
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  image_id                   = "aliyun_3_x64_20G_alibase_20250629.vhd"
  instance_name              = "ecs-for-gtm-test"
  vswitch_id                 = alicloud_vswitch.vsw.id
  internet_max_bandwidth_out = 5
}

resource "alicloud_security_group_rule" "allow_tcp_22" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_tcp_3389" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "3389/3389"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_tcp_80" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_tcp_443" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "443/443"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

locals {
  command_content = <<EOF
#!/bin/sh
sudo yum install nginx -y
sudo nginx
EOF
}

resource "alicloud_ecs_command" "deploy" {
  name            = "deploy_nginx"
  type            = "RunShellScript"
  command_content = base64encode(local.command_content)
  timeout         = 3600
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "invocation" {
  instance_id = [alicloud_instance.instance.id]
  command_id  = alicloud_ecs_command.deploy.id
  timeouts {
    create = "5m"
  }
}

output "url" {
  value = format("http://%v", alicloud_instance.instance.public_ip)
}
