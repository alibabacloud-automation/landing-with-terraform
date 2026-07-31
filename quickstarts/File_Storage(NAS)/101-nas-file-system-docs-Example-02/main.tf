resource "alicloud_nas_file_system" "cpfs" {
  protocol_type    = "cpfs"
  storage_type     = "advance_100"
  file_system_type = "cpfs"
  capacity         = 3600
  zone_id          = "cn-hangzhou-i"
  # vpc_id and vswitch_id are required when file_system_type = cpfs
  vpc_id     = "vpc-xxxxxxxxxxxxxxxxxxxxx"
  vswitch_id = "vsw-xxxxxxxxxxxxxxxxxxxxx"
}