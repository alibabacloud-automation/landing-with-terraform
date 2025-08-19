# ECS 相关资源
data "alicloud_instance_types" "types1" {
  provider             = alicloud.region1
  availability_zone    = var.zone11_id
  system_disk_category = var.system_disk_category
}

data "alicloud_instance_types" "types2" {
  provider             = alicloud.region2
  availability_zone    = var.zone21_id
  system_disk_category = var.system_disk_category
}

data "alicloud_instance_types" "types3" {
  provider             = alicloud.region3
  availability_zone    = var.zone31_id
  system_disk_category = var.system_disk_category
}

# 安全组
resource "alicloud_security_group" "group1" {
  provider = alicloud.region1
  vpc_id   = alicloud_vpc.vpc1.id
}

resource "alicloud_security_group_rule" "rule1" {
  provider          = alicloud.region1
  type              = "ingress"
  ip_protocol       = "all"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.group1.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group" "group2" {
  provider = alicloud.region2
  vpc_id   = alicloud_vpc.vpc2.id
}

resource "alicloud_security_group_rule" "rule2" {
  provider          = alicloud.region2
  type              = "ingress"
  ip_protocol       = "all"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.group2.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group" "group3" {
  provider = alicloud.region3
  vpc_id   = alicloud_vpc.vpc3.id
}

resource "alicloud_security_group_rule" "rule3" {
  provider          = alicloud.region3
  type              = "ingress"
  ip_protocol       = "all"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.group3.id
  cidr_ip           = "0.0.0.0/0"
}

# ECS 实例
locals {
  ecs1_user_data = <<-EOF
#!/bin/sh
echo "Hello World ! This is ECS01." > index.html
nohup python3 -m http.server 80 &
EOF

  ecs2_user_data = <<-EOF
#!/bin/sh
echo "Hello World ! This is ECS02." > index.html
nohup python3 -m http.server 80 &
EOF

  ecs3_user_data = <<-EOF
#!/bin/sh
echo "Hello World ! This is ECS03." > index.html
nohup python3 -m http.server 80 &
EOF
}

resource "alicloud_instance" "ecs1" {
  provider             = alicloud.region1
  availability_zone    = var.zone11_id
  security_groups      = [alicloud_security_group.group1.id]
  instance_type        = data.alicloud_instance_types.types1.ids[0]
  system_disk_category = var.system_disk_category
  image_id             = "aliyun_3_x64_20G_alibase_20230727.vhd"
  instance_name        = "ECS1"
  vswitch_id           = alicloud_vswitch.vsw11.id
  password             = var.ecs_password
  user_data            = local.ecs1_user_data
}

resource "alicloud_instance" "ecs2" {
  provider             = alicloud.region2
  availability_zone    = var.zone21_id
  security_groups      = [alicloud_security_group.group2.id]
  instance_type        = data.alicloud_instance_types.types2.ids[0]
  system_disk_category = var.system_disk_category
  image_id             = "aliyun_3_x64_20G_alibase_20230727.vhd"
  instance_name        = "ECS2"
  vswitch_id           = alicloud_vswitch.vsw21.id
  password             = var.ecs_password
  user_data            = local.ecs2_user_data
}

resource "alicloud_instance" "ecs3" {
  provider             = alicloud.region3
  availability_zone    = var.zone31_id
  security_groups      = [alicloud_security_group.group3.id]
  instance_type        = data.alicloud_instance_types.types3.ids[0]
  system_disk_category = var.system_disk_category
  image_id             = "aliyun_3_x64_20G_alibase_20230727.vhd"
  instance_name        = "ECS3"
  vswitch_id           = alicloud_vswitch.vsw31.id
  password             = var.ecs_password
  user_data            = local.ecs3_user_data
}