variable "name" {
  default = "terraform-example"
}
# 创建ENS EIP资源
resource "alicloud_ens_eip" "default" {
  # （可选）EIP的描述。
  description = "EipDescription_autotest"
  # （可选，计算得出）EIP的峰值带宽。规则：默认值：5，取值范围：5~10000
  bandwidth = "5"
  # （可选，强制新建）互联网服务提供商
  isp = "cmcc"
  # （必需，强制新建）EIP实例的计费类型。值：按需付费（PayAsYouGo）
  payment_type = "PayAsYouGo"
  # （必需，强制新建）ENS节点ID。
  ens_region_id = "cn-chenzhou-telecom_unicom_cmcc"
  # 可选）EIP实例的名称。
  eip_name = var.name
  # （必需，强制新建）EIP实例的计费类型。有效值：95BandwidthByMonth。
  internet_charge_type = "95BandwidthByMonth"
}