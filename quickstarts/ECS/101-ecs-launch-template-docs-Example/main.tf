data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}
data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones.0.id
}

data "alicloud_images" "default" {
  name_regex = "^ubuntu_[0-9]+_[0-9]+_x64*"
  owners     = "system"
}

resource "alicloud_vpc" "default" {
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  name   = "terraform-example"
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_ecs_launch_template" "default" {
  launch_template_name          = "terraform-example"
  description                   = "terraform-example"
  image_id                      = data.alicloud_images.default.images.0.id
  host_name                     = "terraform-example"
  instance_charge_type          = "PrePaid"
  instance_name                 = "terraform-example"
  instance_type                 = data.alicloud_instance_types.default.instance_types.0.id
  internet_charge_type          = "PayByBandwidth"
  internet_max_bandwidth_in     = "5"
  internet_max_bandwidth_out    = "5"
  io_optimized                  = "optimized"
  key_pair_name                 = "key_pair_name"
  ram_role_name                 = "ram_role_name"
  network_type                  = "vpc"
  security_enhancement_strategy = "Active"
  spot_price_limit              = "5"
  spot_strategy                 = "SpotWithPriceLimit"
  security_group_ids            = [alicloud_security_group.default.id]
  system_disk {
    category             = "cloud_ssd"
    description          = "Test For Terraform"
    name                 = "terraform-example"
    size                 = "40"
    delete_with_instance = "false"
  }

  user_data  = "xxxxxxx"
  vswitch_id = alicloud_vswitch.default.id
  vpc_id     = alicloud_vpc.default.id
  zone_id    = data.alicloud_zones.default.zones.0.id

  template_tags = {
    Create = "Terraform"
    For    = "example"
  }

  network_interfaces {
    name              = "eth0"
    description       = "hello1"
    primary_ip        = "10.0.0.2"
    security_group_id = alicloud_security_group.default.id
    vswitch_id        = alicloud_vswitch.default.id
  }

  data_disks {
    name                 = "disk1"
    description          = "description"
    delete_with_instance = "true"
    category             = "cloud"
    encrypted            = "false"
    performance_level    = "PL0"
    size                 = "20"
  }
  data_disks {
    name                 = "disk2"
    description          = "description2"
    delete_with_instance = "true"
    category             = "cloud"
    encrypted            = "false"
    performance_level    = "PL0"
    size                 = "20"
  }
}