variable "source_region" {
  default = "cn-hangzhou"
}
variable "destination_region" {
  default = "cn-shanghai"
}

provider "alicloud" {
  alias  = "hz"
  region = var.source_region
}
provider "alicloud" {
  alias  = "sh"
  region = var.destination_region
}

resource "alicloud_vpc" "example_hz" {
  provider   = alicloud.hz
  vpc_name   = "tf_example"
  cidr_block = "192.168.0.0/16"
}
resource "alicloud_vpc" "example_sh" {
  provider   = alicloud.sh
  vpc_name   = "tf_example"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_cen_instance" "example" {
  cen_instance_name = "tf_example"
  description       = "an example for cen"
}
resource "alicloud_cen_instance_attachment" "example_hz" {
  instance_id              = alicloud_cen_instance.example.id
  child_instance_id        = alicloud_vpc.example_hz.id
  child_instance_type      = "VPC"
  child_instance_region_id = var.source_region
}
resource "alicloud_cen_instance_attachment" "example_sh" {
  instance_id              = alicloud_cen_instance.example.id
  child_instance_id        = alicloud_vpc.example_sh.id
  child_instance_type      = "VPC"
  child_instance_region_id = var.destination_region
}

resource "alicloud_cen_route_map" "default" {
  cen_region_id                          = var.source_region
  cen_id                                 = alicloud_cen_instance.example.id
  description                            = "tf_example"
  priority                               = "1"
  transmit_direction                     = "RegionIn"
  map_result                             = "Permit"
  next_priority                          = "1"
  source_region_ids                      = [var.source_region]
  source_instance_ids                    = [alicloud_cen_instance_attachment.example_hz.child_instance_id]
  source_instance_ids_reverse_match      = "false"
  destination_instance_ids               = [alicloud_cen_instance_attachment.example_sh.child_instance_id]
  destination_instance_ids_reverse_match = "false"
  source_route_table_ids                 = [alicloud_vpc.example_hz.route_table_id]
  destination_route_table_ids            = [alicloud_vpc.example_sh.route_table_id]
  source_child_instance_types            = ["VPC"]
  destination_child_instance_types       = ["VPC"]
  destination_cidr_blocks                = [alicloud_vpc.example_sh.cidr_block]
  cidr_match_mode                        = "Include"
  route_types                            = ["System"]
  match_asns                             = ["65501"]
  as_path_match_mode                     = "Include"
  match_community_set                    = ["65501:1"]
  community_match_mode                   = "Include"
  community_operate_mode                 = "Additive"
  operate_community_set                  = ["65501:1"]
  preference                             = "20"
  prepend_as_path                        = ["65501"]
}