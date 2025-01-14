provider "alicloud" {
  region = var.region
}

variable "region" {
  default = "cn-beijing"
}

variable "common_name" {
  description = "Common name for resources."
  type        = string
  default     = "deploy_rabbitmq_by_tf"
}

variable "system_disk_category" {
  default     = "cloud_essd"
  description = "The category of the system disk."
}

variable "instance_password" {
  description = "Server login password, length 8-30, must contain three (Capital letters, lowercase letters, numbers, `~!@#$%^&*_-+=|{}[]:;'<>?,./ Special symbol in)"
  type        = string
  default     = "Test@123456"
}

variable "image_id" {
  description = "Image of instance. Supported only on Ubuntu."
  type        = string
  default     = "ubuntu_22_04_x64_20G_alibase_20241224.vhd"
}

variable "instance_type" {
  description = "Instance type."
  type        = string
  default     = "ecs.e-c1m2.large"
}

variable "access_ip" {
  description = "The IP address you used to access the ECS."
  type        = string
  default     = "0.0.0.0/0"
}

variable "rabbitmq_user_name" {
  description = "Create a new user for RabbitMQ."
  type        = string
  default     = "rabbitmq@new_user"
}

variable "rabbitmq_user_password" {
  description = "Password for a new RabbitMQ user."
  type        = string
  default     = "rabbitmq@pw12345"
}

# 查询满足条件的可用区
data "alicloud_zones" "default" {
  available_disk_category     = var.system_disk_category
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

resource "alicloud_vpc" "rabbitmq_vpc" {
  vpc_name   = "${var.common_name}-vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "rabbitmq_vsw" {
  vpc_id       = alicloud_vpc.rabbitmq_vpc.id
  vswitch_name = "${var.common_name}-vsw"
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "rabbitmq_sg" {
  security_group_name = "${var.common_name}-sg"
  vpc_id              = alicloud_vpc.rabbitmq_vpc.id
}

resource "alicloud_security_group_rule" "allow_tcp_22" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.rabbitmq_sg.id
  cidr_ip           = var.access_ip
}

resource "alicloud_security_group_rule" "allow_tcp_80" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.rabbitmq_sg.id
  cidr_ip           = var.access_ip
}

resource "alicloud_security_group_rule" "allow_tcp_15672" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "15672/15672"
  priority          = 1
  security_group_id = alicloud_security_group.rabbitmq_sg.id
  cidr_ip           = var.access_ip
}

resource "alicloud_security_group_rule" "allow_icmp_all" {
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.rabbitmq_sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "rabbitmq_ecs" {
  availability_zone          = data.alicloud_zones.default.zones.0.id
  security_groups            = [alicloud_security_group.rabbitmq_sg.id]
  instance_type              = var.instance_type
  system_disk_category       = var.system_disk_category
  image_id                   = var.image_id
  instance_name              = "${var.common_name}-ecs"
  vswitch_id                 = alicloud_vswitch.rabbitmq_vsw.id
  internet_max_bandwidth_out = 10
  password                   = var.instance_password
}

locals {
  command_content = <<SHELL
#!/bin/sh

sudo apt-get install curl gnupg apt-transport-https -y

## Team RabbitMQ's main signing key
curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
## Community mirror of Cloudsmith: modern Erlang repository
curl -1sLf https://github.com/rabbitmq/signing-keys/releases/download/3.0/cloudsmith.rabbitmq-erlang.E495BB49CC4BBE5B.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg > /dev/null
## Community mirror of Cloudsmith: RabbitMQ repository
curl -1sLf https://github.com/rabbitmq/signing-keys/releases/download/3.0/cloudsmith.rabbitmq-server.9F4587F226208342.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/rabbitmq.9F4587F226208342.gpg > /dev/null

## Add apt repositories maintained by Team RabbitMQ
sudo tee /etc/apt/sources.list.d/rabbitmq.list <<EOF
## Provides modern Erlang/OTP releases
deb [arch=amd64 signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa1.rabbitmq.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main
deb-src [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa1.rabbitmq.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main

# another mirror for redundancy
deb [arch=amd64 signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa2.rabbitmq.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main
deb-src [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa2.rabbitmq.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main

## Provides RabbitMQ
deb [arch=amd64 signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa1.rabbitmq.com/rabbitmq/rabbitmq-server/deb/ubuntu jammy main
deb-src [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa1.rabbitmq.com/rabbitmq/rabbitmq-server/deb/ubuntu jammy main

# another mirror for redundancy
deb [arch=amd64 signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa2.rabbitmq.com/rabbitmq/rabbitmq-server/deb/ubuntu jammy main
deb-src [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa2.rabbitmq.com/rabbitmq/rabbitmq-server/deb/ubuntu jammy main
EOF

## Update package indices
sudo apt-get update -y

## Install Erlang packages
sudo apt-get install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

## Install rabbitmq-server and its dependencies
sudo apt-get install rabbitmq-server -y --fix-missing

sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server

sudo rabbitmqctl delete_user guest
sudo rabbitmqctl add_user ${var.rabbitmq_user_name} ${var.rabbitmq_user_password}
sudo rabbitmqctl set_user_tags ${var.rabbitmq_user_name} administrator
sudo rabbitmqctl set_permissions -p / ${var.rabbitmq_user_name} ".*" ".*" ".*"
sudo rabbitmq-plugins enable rabbitmq_management

SHELL
}

resource "alicloud_ecs_command" "deploy_rabbitmq" {
  name            = "DeploydRabbitMQ"
  type            = "RunShellScript"
  command_content = base64encode(local.command_content)
  timeout         = 3600
  working_dir     = "/root"
}


resource "alicloud_ecs_invocation" "invocation" {
  instance_id = [alicloud_instance.rabbitmq_ecs.id]
  command_id  = alicloud_ecs_command.deploy_rabbitmq.id
  timeouts {
    create = "5m"
  }
}

output "rabbitmq-login_url" {
  value = format("http://%s:15672", alicloud_instance.rabbitmq_ecs.public_ip)
}