resource "alicloud_cloud_firewall_instance" "example" {
  # 资源的支付类型。有效值：Subscription（订阅），PayAsYouGo（按需计费）。
  payment_type = "Subscription"
  # 当前版本。premium_version（高级版）、enterprise_version（企业版）、ultimate_version（终极版）。
  spec = "premium_version"
  # 可保护的公网 IP 数量。有效值：20 到 4000。
  ip_number = 20
  # 公共网络处理能力。有效值：10 到 15000。单位：Mbps。
  band_width = 10
  # 是否使用日志审计。有效值：true，false。
  cfw_log = false
  # 日志存储容量。当 cfw_log = false 时将被忽略。
  cfw_log_storage = 1000
  # 属性 cfw_service 不再支持更长的设置，已于 v1.209.1 版本中移除。
  # cfw_service     = false
  # 预付费期。有效值：1, 3, 6, 12, 24, 36。
  period = 1
}