provider "alicloud" {
}

# 生成随机字符串
resource "random_string" "random_string" {
  length  = 10
  special = false
  upper   = false
  numeric = true
  lower   = true
}

# VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc_SDWebUI"
  cidr_block = "192.168.0.0/16"
}

# VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id     = alicloud_vpc.vpc.id
  availability_zone = var.zone_id
  cidr_block = "192.168.0.0/18"
  vswitch_name = "vswitch_SDWebUI"
}

# NAT网关
resource "alicloud_nat_gateway" "nat_gateway" {
  vpc_id               = alicloud_vpc.vpc.id
  vswitch_id           = alicloud_vswitch.vswitch.id
  nat_gateway_name     = "nat_SDWebUI"
  instance_charge_type = "PostPaid"
  internet_charge_type = "PayByLcu"
  nat_type             = "Enhanced"
  network_type         = "internet"
  
  tags = {
    WebUI = "SD_WebUI"
  }
}

# EIP
resource "alicloud_eip" "eip" {
  name                  = "eip_SDWebUI"
  bandwidth             = 200
  internet_charge_type  = "PayByTraffic"
}

# EIP关联到NAT网关
resource "alicloud_eip_association" "eip_association" {
  allocation_id = alicloud_eip.eip.id
  instance_id   = alicloud_nat_gateway.nat_gateway.id
}

# SNAT条目
resource "alicloud_snat_entry" "snat_entry" {
  snat_table_id = alicloud_nat_gateway.nat_gateway.snat_table_ids
  snat_ip        = alicloud_eip.eip.ip_address
  source_cidr    = "192.168.0.0/18"
  
  depends_on = [alicloud_eip_association.eip_association]
}

# 安全组
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg_SDWebUI"
  security_group_type = "normal"
}

# 安全组入站规则 - 80端口
resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "0.0.0.0/0"
}

# 安全组入站规则 - 443端口
resource "alicloud_security_group_rule" "allow_https" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "443/443"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "0.0.0.0/0"
}

# NAS文件系统
resource "alicloud_nas_file_system" "nas" {
  file_system_type = "standard"
  storage_type   = "Performance"
  protocol_type  = "NFS"
  encrypt_type   = 0
}

# NAS访问组
resource "alicloud_nas_access_group" "nas_access_group" {
  access_group_type = "Vpc"
  access_group_name = "nas_accessgroup_SDWebUI"
  file_system_type  = "standard"
}

# NAS访问规则
resource "alicloud_nas_access_rule" "nas_access_rule" {
  priority          = 100
  user_access_type  = "no_squash"
  access_group_name = alicloud_nas_access_group.nas_access_group.access_group_name
  source_cidr_ip    = "0.0.0.0/0"
  rw_access_type    = "RDWR"
  file_system_type  = "standard"
}

# NAS挂载点
resource "alicloud_nas_mount_target" "nas_mount_target" {
  vpc_id           = alicloud_vpc.vpc.id
  vswitch_id       = alicloud_vswitch.vswitch.id
  security_group_id = alicloud_security_group.security_group.id
  status           = "Active"
  file_system_id   = alicloud_nas_file_system.nas.id
  network_type     = "Vpc"
  access_group_name = alicloud_nas_access_group.nas_access_group.access_group_name
  
  depends_on = [alicloud_nas_access_rule.nas_access_rule]
}

# PAI-EAS服务
resource "alicloud_pai_service" "pai_eas" {
  service_config = jsonencode({
    metadata = {
      name = "sdwebui_${random_string.random_string.result}"
      instance = 1
      type = "SDCluster"
      enable_webservice = "true"
    }
    cloud = {
      computing = {
        instance_type = var.instance_type
        instances = null
      }
      networking = {
        vpc_id = alicloud_vpc.vpc.id
        vswitch_id = alicloud_vswitch.vswitch.id
        security_group_id = alicloud_security_group.security_group.id
      }
    }
    storage = [
      {
        nfs = {
          path = "/"
          server = alicloud_nas_mount_target.nas_mount_target.mount_target_domain
        }
        properties = {
          resource_type = "model"
        }
        mount_path = "/code/stable-diffusion-webui/data-nas"
      }
    ]
    containers = [
      {
        image = "eas-registry-vpc.ap-southeast-1.cr.aliyuncs.com/pai-eas/stable-diffusion-webui:4.1"
        script = "./webui.sh --listen --port 8000 --skip-version-check --no-hashing --no-download-sd-model --skip-install --api --filebrowser --cluster-status --sd-dynamic-cache --data-dir /code/stable-diffusion-webui/data-nas"
        port = 8000
      }
    ]
    meta = {
      type = "SDCluster"
    }
    options = {
      enableCache = true
    }
  })
  timeouts {
    create = "20m"
  }
} 