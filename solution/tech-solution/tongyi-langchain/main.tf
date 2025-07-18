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

# VPC
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "vpc_qwen_demo"
}

# VSwitch
resource "alicloud_vswitch" "vswitch" {
  zone_id      = var.zone_id
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  vswitch_name = "vswitch_qwen_demo"
}

# 安全组
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg_qwen_demo"
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

# 安全组入站规则 - 3389端口
resource "alicloud_security_group_rule" "allow_rdp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "3389/3389"
  priority          = 1
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = "0.0.0.0/0"
}

# NAS文件系统
resource "alicloud_nas_file_system" "nas_file_system" {
  protocol_type    = "NFS"
  file_system_type = "standard"
  storage_type     = "Performance"
  zone_id          = var.zone_id
  description      = "NAS文件系统用于Qwen和LangChain对话模型"
}

# NAS访问组
resource "alicloud_nas_access_group" "nas_access_group" {
  access_group_type = "Vpc"
  access_group_name = "nas-access-group-qwen-demo"
}

# NAS挂载点
resource "alicloud_nas_mount_target" "nas_mount_target" {
  vpc_id            = alicloud_vpc.vpc.id
  vswitch_id        = alicloud_vswitch.vswitch.id
  network_type      = "Vpc"
  access_group_name = alicloud_nas_access_group.nas_access_group.access_group_name
  file_system_id    = alicloud_nas_file_system.nas_file_system.id

  depends_on = [alicloud_nas_access_rule.nas_access_rule]
}

# NAS访问规则
resource "alicloud_nas_access_rule" "nas_access_rule" {
  source_cidr_ip    = "0.0.0.0/0"
  access_group_name = alicloud_nas_access_group.nas_access_group.access_group_name
}

# PAI-EAS服务
resource "alicloud_pai_service" "pai_eas" {
  service_config = jsonencode({
    metadata = {
      name              = "qwen_demo_${random_string.random_string.result}"
      instance          = 1
      enable_webservice = "true"
      cpu               = 8
      gpu               = 1
      memory            = 30000
    }
    cloud = {
      computing = {
        instance_type = var.instance_type
      }
    }
    containers = [
      {
        image  = "eas-registry-vpc.${data.alicloud_regions.current.regions.0.id}.cr.aliyuncs.com/pai-eas/chat-llm-webui:2.1"
        script = "python webui/webui_server.py --port=8000 --model-path=Qwen/Qwen-7B-Chat"
        port   = 8000
      }
    ]
  })

  timeouts {
    create = "20m"
  }
}

# 获取当前区域信息
data "alicloud_regions" "current" {
  current = true
} 