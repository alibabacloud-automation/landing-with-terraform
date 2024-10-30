data "alicloud_threat_detection_assets" "default" {
  machine_types = "ecs"
}
resource "alicloud_threat_detection_web_lock_config" "default" {
  inclusive_file_type = "php;jsp;asp;aspx;js;cgi;html;htm;xml;shtml;shtm;jpg"
  uuid                = data.alicloud_threat_detection_assets.default.ids.0
  mode                = "whitelist"
  local_backup_dir    = "/usr/local/aegis/bak"
  dir                 = "/tmp/"
  defence_mode        = "audit"
}