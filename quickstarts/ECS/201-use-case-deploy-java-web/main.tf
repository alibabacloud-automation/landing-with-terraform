provider "alicloud" {
  region = var.region
}

variable "ecs_instance_id" {
  default     = ""
  description = "ECS instance ID if using an existing instance"
}

variable "common_name" {
  default     = "deploy-java-web-by-terraform"
  description = "Common name for resources"
}

variable "instance_password" {
  default     = "Test@123456"
  description = "Server login password"
}

variable "image_id" {
  default     = "aliyun_3_x64_20G_alibase_20240528.vhd"
  description = "Image ID for the instance"
}

variable "instance_type" {
  description = "Instance type"
  default     = "ecs.e-c1m2.large"
}

variable "region" {
  description = "Region where resources will be created"
  default     = "cn-chengdu"
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

resource "alicloud_vpc" "vpc" {
  count      = local.create_instance ? 1 : 0
  vpc_name   = "${var.common_name}-vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "vswitch" {
  count        = local.create_instance ? 1 : 0
  vpc_id       = alicloud_vpc.vpc[0].id
  vswitch_name = "${var.common_name}-vsw"
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "sg" {
  security_group_name = "${var.common_name}-sg"
  vpc_id              = local.vpc_id
  description         = "Security group for ECS instance"
}

resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_web" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "8080/8080"
  priority          = 1
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_icmp" {
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "ecs_instance" {
  count                      = local.create_instance ? 1 : 0
  instance_name              = "${var.common_name}-ecs"
  image_id                   = var.image_id
  instance_type              = var.instance_type
  security_groups            = alicloud_security_group.sg.*.id
  vswitch_id                 = alicloud_vswitch.vswitch[0].id
  password                   = var.instance_password
  internet_max_bandwidth_out = 100
  system_disk_category       = "cloud_essd"
}

data "alicloud_instances" "default" {
  count = local.create_instance ? 0 : 1
  ids   = [var.ecs_instance_id]
}

locals {
  create_instance    = var.ecs_instance_id == ""
  command_content    = <<SHELL
#!/bin/bash
if ! command -v java &> /dev/null; then
  if cat /etc/issue|grep -i Ubuntu ; then
    sudo apt -y update
    sudo apt-get install -y openjdk-8-jdk
    java_path=readlink -f $(which java) | awk '{gsub(/\/jre\/bin\/java$/, ""); print}'
  elif cat /etc/issue|grep -i Debian ; then
    sudo apt -y update
    sudo apt-get install -y openjdk-17-jdk
    java_path=$(readlink -f $(which java) | awk '{gsub(/\/bin\/java$/, ""); print}')
  else
    sudo yum -y update
    sudo yum -y install java-1.8.0-openjdk-devel.x86_64
    java_path=readlink -f $(which java) | awk '{gsub(/\/jre\/bin\/java$/, ""); print}'
  fi
fi 

sudo echo "JAVA_HOME=$java_path" >>/etc/profile
sudo echo "PATH=$PATH:$JAVA_HOME/bin" >>/etc/profile
sudo echo "CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >>/etc/profile
sudo echo "export JAVA_HOME CLASSPATH PATH" >>/etc/profile
if cat /etc/issue|grep -i Debian ; then
  source /etc/profile
else
  sudo source /etc/profile
fi

sudo wget -c -t 10 https://help-static-aliyun-doc.aliyuncs.com/software/apache-tomcat-9.0.91.tar.gz  --no-check-certificate 
sudo tar -zxvf apache-tomcat-9.0.91.tar.gz
sudo mv apache-tomcat-9.0.91 /usr/local/tomcat/
sudo echo "JAVA_OPTS='-Djava.security.egd=file:/dev/./urandom -server -Xms512m -Xmx512m -Dfile.encoding=UTF-8'" >> /usr/local/tomcat/bin/setenv.sh

sudo wget -c -t 10 https://help-static-aliyun-doc.aliyuncs.com/software/Tomcat-init.sh
sudo mv Tomcat-init.sh /etc/init.d/tomcat
chmod +x /etc/init.d/tomcat
sudo sed -i 's@^export JAVA_HOME=.*@export JAVA_HOME=$JAVA_HOME@' /etc/init.d/tomcat
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
SHELL
  instance_id        = local.create_instance ? alicloud_instance.ecs_instance[0].id : var.ecs_instance_id
  instance_public_ip = local.create_instance ? element(alicloud_instance.ecs_instance.*.public_ip, 0) : lookup(data.alicloud_instances.default[0].instances.0, "public_ip")
  vpc_id             = local.create_instance ? alicloud_vpc.vpc[0].id : lookup(data.alicloud_instances.default[0].instances.0, "vpc_id")
}

resource "alicloud_ecs_command" "deploy_java_web" {
  name            = "DeployJavaWeb"
  type            = "RunShellScript"
  command_content = base64encode(local.command_content)
  timeout         = 3600
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "invocation" {
  instance_id = [local.instance_id]
  command_id  = alicloud_ecs_command.deploy_java_web.id
  timeouts {
    create = "10m"
  }
}

output "ecs_login_address" {
  value = format("https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=%s&instanceId=%s", var.region, local.instance_id)
}

output "java_web_url" {
  value = format("http://%s:8080", local.instance_public_ip)
}