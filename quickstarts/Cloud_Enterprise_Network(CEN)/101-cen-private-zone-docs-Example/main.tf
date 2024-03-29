data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_vpc" "example" {
  vpc_name   = "tf_example"
  cidr_block = "172.17.3.0/24"
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

resource "alicloud_cen_private_zone" "default" {
  access_region_id = data.alicloud_regions.default.regions.0.id
  cen_id           = alicloud_cen_instance_attachment.example.instance_id
  host_region_id   = data.alicloud_regions.default.regions.0.id
  host_vpc_id      = alicloud_vpc.example.id
}