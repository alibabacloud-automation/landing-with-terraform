variable "region" {
  default = "cn-hangzhou"
}
provider "alicloud" {
  region = var.region
}
variable "image_id" {
  default = "win2022_21H2_x64_dtc_zh-cn_40G_alibase_20211116"
}
variable "instance_type" {
  default = "ens.sn1.small"
}
variable "internet_charge_type" {
  default = "BandwidthByDay"
}
# ENS实例资源
resource "alicloud_ens_instance" "instance" {
  # (可选, Int, 自v1.208.0起可用) 资源购买时长。设置方法：如果PeriodUnit设置为Day，Period只能设置为3；如果PeriodUnit设置为Month，Period可以设置为1-9,12。
  period = 1
  # 数据盘
  #data_disk {
  # 数据盘大小，单位：GB
  #size     = 20
  # 数据盘类型。可选值：cloud_efficiency（高效云盘）、cloud_ssd（SSD云盘）、local_hdd（本地HDD磁盘）、local_ssd（本地SSD磁盘）。
  #category = "cloud_efficiency"
  #}
  #  (可选, 自v1.208.0起可用) 是否分配公网IP标识符。值：true（默认）：分配、false：不分配。
  public_ip_identification = true
  # 购买资源的时间单位。值：Month（默认）：按月购买、Day：按天购买。
  period_unit = "Month"
  # 调度策略。可选值：Concentrate（节点级调度）、Disperse（区域调度）。
  scheduling_strategy = "Disperse"
  # 调度级别，通过它进行节点级调度或区域调度。可选值：Node-level scheduling（节点级调度）：Region；Regional scheduling（区域调度）：Big（区域）、Middle（省）、Small（市）。
  schedule_area_level = "Big"
  # 实例的镜像ID。arm版本卡不能填写。
  image_id = var.image_id
  # 实例规格。
  instance_type = var.instance_type
  # 实例的主机名
  host_name = "Host80"
  # 实例密码
  password = "Ens-test@"
  # 实例带宽计费方式。如果首次购买时可以选择计费方式，则后续该字段的值将按照首次选择的计费方式进行处理。可选值：BandwidthByDay（按日峰值带宽）、95bandwidthbymonth（95峰值带宽）。
  internet_charge_type = var.internet_charge_type
  #  实例付款方式。自v1.230.0起可以修改payment_type。可选值：Subscription（预付费，包年包月）、PayAsYouGo（按量付费）。
  payment_type = "PayAsYouGo"
  # 运营商，为区域调度所需。可选值：cmcc（移动）unicom（联通）telecom（电信）
  carrier = "cmcc"
  # 调度价格策略。如果未填，将默认为低价优先。
  scheduling_price_strategy = "PriceLowPriority"
  # 最大公网带宽
  internet_max_bandwidth_out = 1
  # 节点ID。当ScheduleAreaLevel为Region时，EnsRegionId是必需的。当ScheduleAreaLevel为Big、Middle、Small时，EnsRegionId无效。
  # ens_region_id              = "cn-zhengzhou-telecom"  
  # 添加 net_district_code 参数
  net_district_code = "100102" # 请根据实际规范调整
  # 系统盘规格
  system_disk {
    size = 40
  }
}