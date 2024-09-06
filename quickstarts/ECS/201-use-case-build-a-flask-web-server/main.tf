variable "region" {
  default = "cn-qingdao"
}

variable "web_content" {
  default = "你好，阿里云！"
}

variable "instance_name" {
  default = "deploying-flask-web-server"
}

variable "instance_type" {
  default = "ecs.n1.tiny"
}

variable "image_id" {
  default = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
}

variable "internet_bandwidth" {
  default = 10
}

variable "password" {
  default = "Test@12345"
}

provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = var.instance_name
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "172.16.0.0/21"
  zone_id    = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  name   = var.instance_name
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_instance" "instance" {
  availability_zone          = data.alicloud_zones.default.zones.0.id
  security_groups            = alicloud_security_group.default.*.id
  password                   = var.password
  instance_type              = var.instance_type
  system_disk_category       = "cloud_efficiency"
  image_id                   = var.image_id
  instance_name              = var.instance_name
  vswitch_id                 = alicloud_vswitch.vsw.id
  internet_max_bandwidth_out = var.internet_bandwidth
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

resource "alicloud_security_group_rule" "allow_tcp_5000" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "5000/5000"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

# deploy flask
resource "null_resource" "deploy" {
  triggers = {
    web_content = var.web_content
    script_hash = sha256("${local.app_content}")
  }
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "root"
      password = var.password
      host     = alicloud_instance.instance.public_ip
    }
    inline = [
      # 安装 Flask
      "pip install flask",
      # 部署前先停止 Flask (运行端口是 5000)
      "kill $(netstat -tulnp | grep \":5000\" | awk '{ print $7 }' | cut -d'/' -f1)",
      # 部署 Flask
      "echo \"${local.app_content}\" > /tmp/app.py",
      "nohup python /tmp/app.py &>/tmp/output.log &",
      "sleep 2"
    ]
  }
}
output "flask_url" {
  value = format("http://%v:5000", alicloud_instance.instance.public_ip)
}

locals {
  app_content = <<EOF
# coding=utf-8
from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return '${var.web_content}'.decode('utf-8').encode('utf-8')

app.run(host='0.0.0.0')

EOF
}