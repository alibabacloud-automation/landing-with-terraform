data "alicloud_regions" "default" {
  current = true
}
data "alicloud_zones" "example" {
  available_resource_creation = "Instance"
}
data "alicloud_instance_types" "example" {
  availability_zone = data.alicloud_zones.example.zones.0.id
  cpu_core_count    = 1
  memory_size       = 2
}
data "alicloud_images" "example" {
  name_regex = "^ubuntu_[0-9]+_[0-9]+_x64*"
  owners     = "system"
}

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}
resource "alicloud_vswitch" "example" {
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.example.id
  zone_id      = data.alicloud_zones.example.zones.0.id
}
resource "alicloud_security_group" "example" {
  name   = "terraform-example"
  vpc_id = alicloud_vpc.example.id
}

resource "alicloud_instance" "example" {
  availability_zone          = data.alicloud_zones.example.zones.0.id
  instance_name              = "terraform-example"
  image_id                   = data.alicloud_images.example.images.0.id
  instance_type              = data.alicloud_instance_types.example.instance_types.0.id
  security_groups            = [alicloud_security_group.example.id]
  vswitch_id                 = alicloud_vswitch.example.id
  internet_max_bandwidth_out = 5
}

resource "alicloud_cen_instance" "example" {
  cen_instance_name = "tf_example"
  description       = "an example for cen"
}
resource "alicloud_cen_instance_attachment" "example" {
  instance_id              = alicloud_cen_instance.example.id
  child_instance_id        = alicloud_vpc.example.id
  child_instance_type      = "VPC"
  child_instance_region_id = data.alicloud_regions.default.regions.0.id
}

resource "alicloud_route_entry" "example" {
  route_table_id        = alicloud_vpc.example.route_table_id
  destination_cidrblock = "11.0.0.0/16"
  nexthop_type          = "Instance"
  nexthop_id            = alicloud_instance.example.id
}

resource "alicloud_cen_route_entry" "example" {
  instance_id    = alicloud_cen_instance_attachment.example.instance_id
  route_table_id = alicloud_vpc.example.route_table_id
  cidr_block     = alicloud_route_entry.example.destination_cidrblock
}