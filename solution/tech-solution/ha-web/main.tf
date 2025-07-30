data "alicloud_regions" "current" {
  current = true
}

# 查询实例实例规格
data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7"
  sorted_by            = "CPU"
}

# 查询可用区
data "alicloud_zones" "default" {
  available_instance_type = data.alicloud_instance_types.default.ids.0
}

data "alicloud_images" "instance_image" {
  name_regex  = "^aliyun_3_9_x64_20G_*"
  most_recent = true
  owners      = "system"
}

data "alicloud_nas_zones" "default" {
  file_system_type = "standard"
}

locals {
  valid_zones = [
    for zone in data.alicloud_nas_zones.default.zones : zone.zone_id
    if anytrue([
      for t in zone.instance_types :
      t.protocol_type == "nfs" && t.storage_type == "Capacity"
    ])
  ]

  # 如果有两个或更多 zone，取前两个；否则重复第一个 zone 两次
  nas_target_zones = length(local.valid_zones) >= 2 ? slice(local.valid_zones, 0, 2) : (
    length(local.valid_zones) == 1 ? [local.valid_zones[0], local.valid_zones[0]] : ["invalid-zone", "invalid-zone"]
  )
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "${var.common_name}-vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "ecs_vswitch1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_zones.default.ids.1
  vswitch_name = "${var.common_name}-vsw-1"
}

resource "alicloud_vswitch" "ecs_vswitch2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.2.0/24"
  zone_id      = data.alicloud_zones.default.ids.1
  vswitch_name = "${var.common_name}-vsw-2"
}

resource "alicloud_vswitch" "vswitch3" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.3.0/24"
  zone_id      = local.nas_target_zones.0
  vswitch_name = "${var.common_name}-vsw-3"
}

resource "alicloud_vswitch" "vswitch4" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.4.0/24"
  zone_id      = local.nas_target_zones.1
  vswitch_name = "${var.common_name}-vsw-4"
}

resource "alicloud_security_group" "security_group" {
  security_group_name = "${var.common_name}-sg"
  vpc_id              = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "http" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "ssh" {
  security_group_id = alicloud_security_group.security_group.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "22/22"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "ecs_instance1" {
  instance_name              = "${var.common_name}-ecs-1"
  image_id                   = data.alicloud_images.instance_image.images[0].id
  instance_type              = data.alicloud_instance_types.default.ids.0
  internet_max_bandwidth_out = 10
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.ecs_vswitch1.id
  system_disk_category       = "cloud_essd"
  password                   = var.ecs_instance_password
}

resource "alicloud_instance" "ecs_instance2" {
  instance_name              = "${var.common_name}-ecs-2"
  image_id                   = data.alicloud_images.instance_image.images[0].id
  instance_type              = data.alicloud_instance_types.default.ids.0
  internet_max_bandwidth_out = 10
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.ecs_vswitch2.id
  system_disk_category       = "cloud_essd"
  password                   = var.ecs_instance_password
}

resource "alicloud_nas_file_system" "master_fs" {
  protocol_type = "NFS"
  storage_type  = "Capacity"
  description   = "MasterNAS"
  zone_id       = local.nas_target_zones.0
}

resource "alicloud_nas_mount_target" "master_mt" {
  file_system_id    = alicloud_nas_file_system.master_fs.id
  access_group_name = "DEFAULT_VPC_GROUP_NAME"
  network_type      = "Vpc"
  vswitch_id        = alicloud_vswitch.vswitch3.id
}

resource "alicloud_nas_file_system" "backup_fs" {
  protocol_type = "NFS"
  storage_type  = "Capacity"
  description   = "BackupNAS"
  zone_id       = local.nas_target_zones.1
}

resource "alicloud_nas_mount_target" "backup_mt" {
  file_system_id    = alicloud_nas_file_system.backup_fs.id
  access_group_name = "DEFAULT_VPC_GROUP_NAME"
  network_type      = "Vpc"
  vswitch_id        = alicloud_vswitch.vswitch4.id
}

resource "alicloud_slb_load_balancer" "slb" {
  load_balancer_name   = "${var.common_name}-slb"
  address_type         = "internet"
  instance_charge_type = "PayByCLCU"
}

resource "alicloud_slb_backend_server" "slb_backend" {
  load_balancer_id = alicloud_slb_load_balancer.slb.id
  backend_servers {
    server_id = alicloud_instance.ecs_instance1.id
    weight    = 100
  }
  backend_servers {
    server_id = alicloud_instance.ecs_instance2.id
    weight    = 100
  }
}

resource "alicloud_slb_listener" "http_listener" {
  load_balancer_id          = alicloud_slb_load_balancer.slb.id
  backend_port              = 80
  frontend_port             = 80
  protocol                  = "http"
  bandwidth                 = 10
  health_check              = "on"
  health_check_uri          = "/"
  health_check_connect_port = 80
  healthy_threshold         = 3
  unhealthy_threshold       = 3
  health_check_timeout      = 5
  health_check_interval     = 2
  health_check_http_code    = "http_2xx,http_3xx,http_4xx,http_5xx"
  request_timeout           = 60
  idle_timeout              = 30
}

locals {
  ecs_command = <<-SHELL
    #!/bin/bash
    if [ ! -f .ros.provision ]; then
      echo "Name: 高可用及共享存储Web服务" > .ros.provision
    fi

    name=$(grep "^Name:" .ros.provision | awk -F':' '{print $2}' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    if [[ "$name" != "高可用及共享存储Web服务" ]]; then
      echo "当前实例已使用过\"$name\"教程的一键配置，不能再使用本教程的一键配置"
      exit 0
    fi

    echo "#########################"
    echo "# Check Network"
    echo "#########################"
    ping -c 2 -W 2 aliyun.com > /dev/null
    if [[ $? -ne 0 ]]; then
      echo "当前实例无法访问公网"
      exit 0
    fi

    if ! grep -q "^Step1: Prepare Environment$" .ros.provision; then
      echo "#########################"
      echo "# Prepare Environment"
      echo "#########################"
      systemctl status firewalld
      systemctl stop firewalld
      echo "Step1: Prepare Environment" >> .ros.provision
    else
      echo "#########################"
      echo "# Environment has been ready"
      echo "#########################"
    fi

    if ! grep -q "^Step2: Install Nginx and deploy service$" .ros.provision; then
      echo "#########################"
      echo "# Install Nginx"
      echo "#########################"
      sudo yum -y install nginx
      sudo wget -O /usr/share/nginx/html/index.html https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/file-manage-files/zh-CN/20231013/jhgg/index.html
      sudo wget -O /usr/share/nginx/html/lipstick.png https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/file-manage-files/zh-CN/20230925/zevs/lipstick.png
      sudo systemctl start nginx
      sudo systemctl enable nginx
      echo "Step2: Install Nginx and deploy service" >> .ros.provision
    else
      echo "#########################"
      echo "# Nginx has been installed"
      echo "#########################"
    fi

    if ! grep -q "^Step3: Mount to the ECS" .ros.provision; then
      echo "#########################"
      echo "# Mount to the ECS"
      echo "#########################"
      mkdir /nas_master
      mkdir /nas_backup
      sudo yum install -y nfs-utils
      sudo echo "options sunrpc tcp_slot_table_entries=128" >>  /etc/modprobe.d/sunrpc.conf
      sudo echo "options sunrpc tcp_max_slot_table_entries=128" >>  /etc/modprobe.d/sunrpc.conf
      sudo mount -t nfs -o vers=3,nolock,proto=tcp,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${alicloud_nas_mount_target.master_mt.mount_target_domain}:/ /nas_master
      sudo mount -t nfs -o vers=3,nolock,proto=tcp,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${alicloud_nas_mount_target.backup_mt.mount_target_domain}:/ /nas_backup

      sudo echo "${alicloud_nas_mount_target.master_mt.mount_target_domain}:/ /nas_master nfs vers=3,nolock,proto=tcp,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev,noresvport 0 0" >> /etc/fstab

      sudo echo "${alicloud_nas_mount_target.backup_mt.mount_target_domain}:/ /nas_backup nfs vers=3,nolock,proto=tcp,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev,noresvport 0 0" >> /etc/fstab

      df -h | grep aliyun
    else
      echo "#########################"
      echo "# The ECS has been attached to the Nas"
      echo "#########################"
    fi

    if ! grep -q "^Step4: Shared file$" .ros.provision; then
      echo "#########################"
      echo "# Shared file"
      echo "#########################"
      sudo cp -Lvr /usr/share/nginx/html /nas_master
      sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
      echo "Step4: Shared file" >> .ros.provision
    else
      echo "#########################"
      echo "# File has been Shared"
      echo "#########################"
    fi

    if ! grep -q "^Step5: Install inotify-tools、rsync$" .ros.provision; then
      echo "#########################"
      echo "# Install inotify-tools、rsync"
      echo "#########################"
      sudo yum install -y inotify-tools rsync
      echo "Step6: Install inotify-tools、rsync" >> .ros.provision
    else
      echo "#########################"
      echo "# Inotify-tools has been installed"
      echo "#########################"
    fi
    if ! grep -q "^Step6: Install synchronization server$" .ros.provision; then
      echo "#########################"
      echo "# Install synchronization server"
      echo "#########################"
      sudo wget -P /etc/systemd/system/ https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/file-manage-files/zh-CN/20231017/pftz/sync_nas.sh
      sudo wget -P /etc/systemd/system/ https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/file-manage-files/en-US/20230925/wmaj/sync_check_switch.sh
      sudo chmod +x /etc/systemd/system/sync_nas.sh
      sudo chmod +x /etc/systemd/system/sync_check_switch.sh
      cat > /etc/systemd/system/sync-check-switch.service <<\EOF
    [Unit]
    Description=Sync Check Switch
    After=network.target

    [Service]
    ExecStart=/etc/systemd/system/sync_check_switch.sh
    RestartSec=3
    Restart=always

    [Install]
    WantedBy=default.target
    EOF

      cat > /etc/systemd/system/sync-nas.service <<\EOF
    [Unit]
    Description=Sync NAS Service
    After=network.target

    [Service]
    ExecStart=/etc/systemd/system/sync_nas.sh
    Restart=always
    RestartSec=3

    [Install]
    WantedBy=default.target
    EOF

      sudo systemctl daemon-reload
      sudo systemctl start sync-nas.service
      sudo systemctl enable sync-check-switch.service
      sudo systemctl start sync-check-switch.service
      sudo systemctl enable sync-nas.service
      echo "Step6: Install " >> .ros.provision
    else
      echo "#########################"
      echo "# Synchronization server has been installed"
      echo "#########################"
    fi
  SHELL
}

resource "alicloud_ecs_command" "ecs_command" {
  name             = "${var.common_name}-command"
  description      = "ECS initialization command"
  enable_parameter = false
  type             = "RunShellScript"
  command_content  = base64encode(local.ecs_command)
  timeout          = 300
  working_dir      = "/root"
}

resource "alicloud_ecs_invocation" "invocation" {
  instance_id = [alicloud_instance.ecs_instance1.id, alicloud_instance.ecs_instance2.id]
  command_id  = alicloud_ecs_command.ecs_command.id
  timeouts {
    create = "5m"
  }
}