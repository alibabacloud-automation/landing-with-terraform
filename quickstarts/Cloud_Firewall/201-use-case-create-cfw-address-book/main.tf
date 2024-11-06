resource "alicloud_cloud_firewall_address_book" "example" {
  # 描述
  description = "Created_by_terraform"
  # 地址簿的名称。
  group_name = "IPListExample"
  # 地址簿的类型。有效值：ip、ipv6、domain、port、tag。
  group_type = "ip"
  # 地址列表
  address_list = ["192.0.2.1/32", "192.0.2.2/32"]
}