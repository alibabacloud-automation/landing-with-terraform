data "alicloud_nas_zones" "example" {
  file_system_type = "extreme"
}

resource "alicloud_nas_file_system" "foo" {
  file_system_type = "extreme"
  protocol_type    = "NFS"
  zone_id          = data.alicloud_nas_zones.example.zones[0].zone_id
  storage_type     = "standard"
  capacity         = "100"
}