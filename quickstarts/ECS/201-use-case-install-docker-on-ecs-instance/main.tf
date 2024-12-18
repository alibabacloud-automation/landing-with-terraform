variable "region" {
  default = "cn-shanghai"
}

// If you want to install docker on an existing instance, set create_instance to false and set instance_id to the instance id.
variable "create_instance" {
  default = true
}

variable "instance_id" {
  default = ""
}

variable "instance_name" {
  default = "deploying-docker"
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
  count      = var.create_instance ? 1 : 0
  vpc_name   = var.instance_name
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  count      = var.create_instance ? 1 : 0
  vpc_id     = alicloud_vpc.vpc.0.id
  cidr_block = "172.16.0.0/21"
  zone_id    = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "sg" {
  count  = var.create_instance ? 1 : 0
  name   = var.instance_name
  vpc_id = alicloud_vpc.vpc.0.id
}

resource "alicloud_instance" "instance" {
  count                      = var.create_instance ? 1 : 0
  availability_zone          = data.alicloud_zones.default.zones.0.id
  security_groups            = alicloud_security_group.sg.*.id
  password                   = var.password
  instance_type              = var.instance_type
  system_disk_category       = "cloud_efficiency"
  image_id                   = var.image_id
  instance_name              = var.instance_name
  vswitch_id                 = alicloud_vswitch.vsw.0.id
  internet_max_bandwidth_out = var.internet_bandwidth
}

resource "alicloud_security_group_rule" "allow_tcp_22" {
  count             = var.create_instance ? 1 : 0
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.sg.0.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_tcp_3389" {
  count             = var.create_instance ? 1 : 0
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "3389/3389"
  priority          = 1
  security_group_id = alicloud_security_group.sg.0.id
  cidr_ip           = "0.0.0.0/0"
}
resource "alicloud_security_group_rule" "allow_tcp_80" {
  count             = var.create_instance ? 1 : 0
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.sg.0.id
  cidr_ip           = "0.0.0.0/0"
}
resource "alicloud_security_group_rule" "allow_icmp_-1" {
  count             = var.create_instance ? 1 : 0
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.sg.0.id
  cidr_ip           = "0.0.0.0/0"
}

locals {
  instance_id = var.create_instance ? alicloud_instance.instance[0].id : var.instance_id
}
resource "alicloud_oos_execution" "install" {
  template_name = "ACS-ECS-BulkyConfigureOOSPackageWithTemporaryURL"
  description   = "From TF Test"
  safety_check  = "Skip"
  parameters    = <<EOF
    {
      "action": "install",
      "packageName": "ACS-Extension-DockerCE-1853370294850618",
      "regionId": "${var.region}",
      "targets": {
        "ResourceIds": [
          "${local.instance_id}"
        ],
        "RegionId": "${var.region}",
        "Type": "ResourceIds"
      },
      "parameters": null
    }
	EOF
}

output "ecs_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.region}&instanceId=${local.instance_id}"
}
