provider "alicloud" {
  region = "cn-shenzhen"
}
data "alicloud_nas_zones" "example" {
  file_system_type = "cpfs"
}

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "example" {
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.example.id
  zone_id      = data.alicloud_nas_zones.example.zones[1].zone_id
}

resource "alicloud_nas_file_system" "example" {
  protocol_type    = "cpfs"
  storage_type     = "advance_200"
  file_system_type = "cpfs"
  capacity         = 3600
  zone_id          = data.alicloud_nas_zones.example.zones[1].zone_id
  vpc_id           = alicloud_vpc.example.id
  vswitch_id       = alicloud_vswitch.example.id
}

resource "alicloud_nas_mount_target" "example" {
  file_system_id = alicloud_nas_file_system.example.id
  vswitch_id     = alicloud_vswitch.example.id
}
resource "random_integer" "example" {
  max = 99999
  min = 10000
}
resource "alicloud_oss_bucket" "example" {
  bucket = "example-value-${random_integer.example.result}"
  acl    = "private"
  tags = {
    cpfs-dataflow = "true"
  }
}

resource "alicloud_nas_fileset" "example" {
  file_system_id   = alicloud_nas_mount_target.example.file_system_id
  description      = "terraform-example"
  file_system_path = "/example_path/"
}

resource "alicloud_nas_data_flow" "example" {
  fset_id              = alicloud_nas_fileset.example.fileset_id
  description          = "terraform-example"
  file_system_id       = alicloud_nas_file_system.example.id
  source_security_type = "SSL"
  source_storage       = join("", ["oss://", alicloud_oss_bucket.example.bucket])
  throughput           = 600
}