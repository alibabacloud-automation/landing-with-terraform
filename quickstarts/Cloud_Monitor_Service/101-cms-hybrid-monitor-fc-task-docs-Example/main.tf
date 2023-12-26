variable "name" {
  default = "tf-example"
}
data "alicloud_account" "default" {}

resource "alicloud_cms_namespace" "default" {
  description   = var.name
  namespace     = var.name
  specification = "cms.s1.large"
}

resource "alicloud_cms_hybrid_monitor_fc_task" "default" {
  namespace      = alicloud_cms_namespace.default.id
  yarm_config    = <<EOF
products:
- namespace: acs_ecs_dashboard
  metric_info:
  - metric_list:
    - cpu_total
    - cpu_idle
    - diskusage_utilization
    - CPUUtilization
    - DiskReadBPS
    - InternetOut
    - IntranetOut
    - cpu_system
- namespace: acs_rds_dashboard
  metric_info:
  - metric_list:
    - MySQL_QPS
    - MySQL_TPS
EOF
  target_user_id = data.alicloud_account.default.id
}