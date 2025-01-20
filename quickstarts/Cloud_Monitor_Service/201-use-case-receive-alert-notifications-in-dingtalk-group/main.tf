# 定义区域变量，默认值为 "cn-shenzhen"（深圳）
variable "region" {
  default = "cn-shenzhen"
}

# 设置阿里云提供者的区域配置
provider "alicloud" {
  # 使用前面定义的区域变量
  region = var.region
}

# 定义一个名称变量，用于资源命名，默认值为 "tf-example-HHM"
variable "name" {
  default = "tf-example-HHM"
}

# 定义  DingTalk Webhook URL 用户需要自己获取并设置
variable "dingtalk_webhook_endpoint" {
  description = "DingTalk Webhook URL"
  type        = string
  default     = "https://oapi.dingtalk.com/robot/send?access_token=8e7d6880d9e**************************"
}
# 创建报警联系人组资源
resource "alicloud_cms_alarm_contact_group" "default" {
  # 报警联系人组名称使用了前面定义的名称变量
  alarm_contact_group_name = var.name
  # 描述信息同样使用名称变量
  describe = var.name
}

# 创建监控组资源
resource "alicloud_cms_monitor_group" "default" {
  # 监控组名称使用了前面定义的名称变量
  monitor_group_name = var.name
  # 指定关联的报警联系人组，通过引用上面创建的联系人组资源的 ID
  contact_groups = [alicloud_cms_alarm_contact_group.default.id]
}

# 创建监控组指标规则资源
resource "alicloud_cms_group_metric_rule" "this" {
  # 指定该规则所属的监控组，通过引用上面创建的监控组资源的 ID
  group_id = alicloud_cms_monitor_group.default.id
  # 规则名称使用了前面定义的名称变量
  group_metric_rule_name = var.name
  # 监控类别设置为 ECS 实例
  category = "ecs"
  # 监控的指标名称设置为 CPU 利用率
  metric_name = "CPUUtilization"
  # 命名空间设置为 ECS 控制台仪表板
  namespace = "acs_ecs_dashboard"
  # 规则标识符使用了前面定义的名称变量
  rule_id = var.name
  # 设置聚合周期为 60 秒
  period = "60"
  # 设置统计间隔为 60 秒
  interval = "60"
  # 设置静默时间为 85800 秒（约 23.83 小时），即在触发报警后不重复通知的时间
  silence_time = 85800
  # 设置无效时间区间为午夜到凌晨五点半之间
  no_effective_interval = "00:00-05:30"
  # 设置 Webhook URL 用于接收报警通知，使用前面定义的 Webhook 变量
  webhook = var.dingtalk_webhook_endpoint

  # 定义报警升级策略
  escalations {
    # 当 CPU 利用率平均值大于或等于 90% 且连续 3 次检测都满足条件时触发警告级别报警
    warn {
      comparison_operator = "GreaterThanOrEqualToThreshold"
      statistics          = "Average"
      threshold           = "90"
      times               = 3
    }

    # 当 CPU 利用率平均值小于上周同一时段的 90% 且连续 5 次检测都满足条件时触发信息级别报警
    info {
      comparison_operator = "LessThanLastWeek"
      statistics          = "Average"
      threshold           = "90"
      times               = 5
    }
  }
}