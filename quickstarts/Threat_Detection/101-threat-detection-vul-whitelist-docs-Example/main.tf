resource "alicloud_threat_detection_vul_whitelist" "default" {
  whitelist   = "[{\"aliasName\":\"RHSA-2021:2260: libwebp 安全更新\",\"name\":\"RHSA-2021:2260: libwebp 安全更新\",\"type\":\"cve\"}]"
  target_info = "{\"type\":\"GroupId\",\"uuids\":[],\"groupIds\":[10782678]}"
  reason      = "tf-example-reason"
}