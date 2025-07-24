provider "alicloud" {
  region = var.region
}

# 生成随机字符串
resource "random_string" "random_string" {
  length  = 8
  special = false
  upper   = false
  numeric = true
  lower   = true
}

# 获取当前区域信息
data "alicloud_regions" "current_region_ds" {
  current = true
}

# 动态查询可用区
data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

# 动态查询镜像
data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_x64_20G_alibase_.*"
  most_recent = true
  owners      = "system"
}

# VPC
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "vpc_${var.common_name}"
}

# VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = var.zone_id
  vswitch_name = "vsw_${var.common_name}"
}

# 安全组
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "${var.common_name}-sg"
  security_group_type = "normal"
}

# 安全组入站规则 - SSH端口
# 注意：在VPC中，nic_type必须设置为"intranet"，但这不会阻止从公网访问
# 只要ECS实例有公网IP并且cidr_ip允许相应访问即可
resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "0.0.0.0/0"
}

# 安全组入站规则 - 5000端口
# 注意：在VPC中，nic_type必须设置为"intranet"，但这不会阻止从公网访问
# 只要ECS实例有公网IP并且cidr_ip允许相应访问即可
resource "alicloud_security_group_rule" "allow_app" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "5000/5000"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "0.0.0.0/0"
}

# ECS实例
resource "alicloud_instance" "ecs_instance" {
  instance_name              = "${var.common_name}-ecs_adb"
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  vswitch_id                 = alicloud_vswitch.vswitch.id
  security_groups            = [alicloud_security_group.security_group.id]
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = 100
}

# AnalyticDB实例
resource "alicloud_gpdb_instance" "analyticdb" {
  engine                     = "gpdb"
  engine_version             = "6.0"
  instance_spec              = "4C16G"
  zone_id                    = var.zone_id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  seg_node_num               = 2
  seg_storage_type           = "cloud_essd"
  seg_disk_performance_level = "pl1"
  storage_size               = 50
  vpc_id                     = alicloud_vpc.vpc.id
  ip_whitelist {
    security_ip_list = "192.168.0.0/24"
  }
  description          = "${var.common_name}-adb"
  payment_type         = "PayAsYouGo"
  db_instance_category = "Basic"
  db_instance_mode     = "StorageElastic"
}

# ECS命令
resource "alicloud_ecs_command" "run_command" {
  name = "adb-bailian-install"
  command_content = base64encode(<<EOF
#!/bin/bash

# script exit code:
# 0 - success
# 1 - unsupported system
# 2 - network not available
# 3 - failed to git clone
# 4 - failed to init python environment
# 5 - failed to init git
# 6 - failed to run flask app

# 环境变量配置
cat << EOT >> ~/.bashrc
export SOCKET_ENDPOINT=${alicloud_instance.ecs_instance.public_ip}:5000
export APP_ID=${var.bai_lian_app_id}
export DASHSCOPE_API_KEY=${var.bai_lian_api_key}
EOT
source ~/.bashrc

# 检查是否已经配置过
if [ ! -f .ros.provision ]; then
  echo "Name: 手动搭建AnalyticDB与百炼搭建智能问答系统" > .ros.provision
fi

name=$(grep "^Name:" .ros.provision | awk -F':' '{print $2}' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
if [[ "$name" != "手动搭建AnalyticDB与百炼搭建智能问答系统" ]]; then
  echo "当前实例已使用过\"$name\"教程的一键配置，不能再使用本教程的一键配置"
  exit 1
fi

# Step1: Prepare Environment
if ! grep -q "^Step1: Prepare Environment$" .ros.provision; then
  echo "#########################"
  echo "# Prepare Environment "
  echo "#########################"
  
  # 安装Python-3.9.7
  sudo yum update -y && \
  sudo yum groupinstall "Development Tools" -y && \
  sudo yum install openssl-devel bzip2-devel libffi-devel -y
  
  cd /usr/src && \
  sudo curl -O https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20240729/unpfxr/Python-3.9.0.tgz && \
  sudo tar xzf Python-3.9.0.tgz && \
  cd Python-3.9.0 && \
  sudo ./configure --enable-optimizations && \
  sudo make altinstall

  python3.9 --version && \
  python3.9 -m ensurepip && \
  python3.9 -m pip install --upgrade pip

  echo "Step1: Prepare Environment" >> .ros.provision
else
  echo "#########################"
  echo "# Environment has been ready"
  echo "#########################"
fi

# Step2: Deployment service
if ! grep -q "^Step2: Deployment service$" .ros.provision; then
  echo "#########################"
  echo "# Deployment service "
  echo "#########################"
  
  cd /root
  wget https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20240729/unpfxr/demo.zip
  sudo yum install -y unzip
  unzip demo.zip
  cd demo
  python3.9 -m venv $(pwd)/venv
  source $(pwd)/venv/bin/activate
  pip3 install -r requirements.txt
  # 解决Python包版本兼容性问题
  # 1. 卸载可能存在问题的包
  pip3 uninstall -y aiohttp flask-socketio python-socketio
  # 2. 安装已知兼容的特定版本
  pip3 install aiohttp==3.8.1 flask-socketio==5.3.0 python-socketio==5.6.0
  sed "s/socketio.run(app, debug=True, host='0.0.0.0')/socketio.run(app, debug=True, host='0.0.0.0', allow_unsafe_werkzeug=True)/" app-stream.py > temp_app_stream.py
  mv temp_app_stream.py app-stream.py
  rm -rf temp_app_stream.py
  nohup python3.9 app-stream.py > app-stream.log 2>&1 &
  
  echo "Step2: Deployment service" >> .ros.provision
else
  echo "#########################"
  echo "# Service deployed"
  echo "#########################"
fi

echo "Deployment completed successfully!"
EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 7200
}

# 调用命令资源
resource "alicloud_ecs_invocation" "invoke_script" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.run_command.id
  timeouts {
    create = "120m"
  }
} 