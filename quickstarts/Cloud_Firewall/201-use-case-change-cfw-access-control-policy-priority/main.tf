resource "alicloud_cloud_firewall_control_policy" "example" {
  # 访问控制策略支持的应用类型。有效值：ANY, HTTP, HTTPS, MQTT, Memcache, MongoDB, MySQL, RDP, Redis, SMTP, SMTPS, SSH, SSL, VNC。
  application_name = "ANY"
  # 云防火墙对流量执行的操作。有效值：accept, drop, log。
  acl_action = "accept"
  # 描述
  description = "Created_by_terraform"
  # 访问控制策略中的目标地址类型。有效值：net, group, domain, location。
  destination_type = "net"
  # 访问控制策略中的目标地址。
  destination = "100.1.1.0/24"
  # 访问控制策略适用的流量方向。有效值：in, out。
  direction = "out"
  # 访问控制策略支持的协议类型。有效值：ANY, TCP, UDP, ICMP。
  proto = "ANY"
  # 访问控制策略中的源地址。
  source = "1.2.3.0/24"
  # 访问控制策略中的源地址类型。有效值：net, group, location。
  source_type = "net"
}
# 调整互联网防火墙访问控制策略优先级
resource "alicloud_cloud_firewall_control_policy_order" "example" {
  # 访问控制策略的唯一 ID
  acl_uuid = alicloud_cloud_firewall_control_policy.example.acl_uuid
  # 适用于哪个方向流量的访问控制策略。有效值：in, out。
  direction = "out"
  # 访问控制策略的优先级。优先级值从 1 开始。较小的优先级值表示较高的优先级。注意： 值 -1 表示最低优先级。
  order = 1
}