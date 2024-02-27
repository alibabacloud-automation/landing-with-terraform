data "alicloud_nas_zones" "example" {
  file_system_type = "standard"
}

resource "alicloud_nas_file_system" "example" {
  protocol_type = "NFS"
  storage_type  = "Performance"
  description   = "terraform-example"
  encrypt_type  = "1"
  zone_id       = data.alicloud_nas_zones.example.zones[0].zone_id
}

resource "alicloud_nas_recycle_bin" "example" {
  file_system_id = alicloud_nas_file_system.example.id
  reserved_days  = 3
}