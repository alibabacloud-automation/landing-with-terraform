data "alicloud_nas_zones" "example" {
  file_system_type = "standard"
}

resource "alicloud_nas_file_system" "foo" {
  protocol_type = "NFS"
  storage_type  = "Performance"
  description   = "terraform-example"
  encrypt_type  = "1"
  zone_id       = data.alicloud_nas_zones.example.zones[0].zone_id
}