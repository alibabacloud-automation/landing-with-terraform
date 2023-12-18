variable "name" {
  default = "tf_example"
}
variable "domain_name" {
  default = "alicloud-provider.com"
}
data "alicloud_resource_manager_resource_groups" "default" {}
resource "alicloud_cms_alarm_contact_group" "default" {
  alarm_contact_group_name = var.name
}

resource "alicloud_alidns_gtm_instance" "default" {
  instance_name           = var.name
  payment_type            = "Subscription"
  period                  = 1
  renewal_status          = "ManualRenewal"
  package_edition         = "standard"
  health_check_task_count = 100
  sms_notification_count  = 1000
  public_cname_mode       = "SYSTEM_ASSIGN"
  ttl                     = 60
  cname_type              = "PUBLIC"
  resource_group_id       = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  alert_group             = [alicloud_cms_alarm_contact_group.default.alarm_contact_group_name]
  public_user_domain_name = var.domain_name
  alert_config {
    sms_notice      = true
    notice_type     = "ADDR_ALERT"
    email_notice    = true
    dingtalk_notice = true
  }
}

resource "alicloud_alidns_address_pool" "default" {
  count             = 2
  address_pool_name = format("${var.name}_%d", count.index + 1)
  instance_id       = alicloud_alidns_gtm_instance.default.id
  lba_strategy      = "RATIO"
  type              = "IPV4"
  address {
    attribute_info = "{\"lineCodeRectifyType\":\"RECTIFIED\",\"lineCodes\":[\"os_namerica_us\"]}"
    remark         = "address_remark"
    address        = "1.1.1.1"
    mode           = "SMART"
    lba_weight     = 1
  }
}

resource "alicloud_alidns_access_strategy" "default" {
  strategy_name                  = var.name
  strategy_mode                  = "GEO"
  instance_id                    = alicloud_alidns_gtm_instance.default.id
  default_addr_pool_type         = "IPV4"
  default_lba_strategy           = "RATIO"
  default_min_available_addr_num = 1
  default_addr_pools {
    lba_weight   = 1
    addr_pool_id = alicloud_alidns_address_pool.default.0.id
  }
  failover_addr_pool_type         = "IPV4"
  failover_lba_strategy           = "RATIO"
  failover_min_available_addr_num = 1
  failover_addr_pools {
    lba_weight   = 1
    addr_pool_id = alicloud_alidns_address_pool.default.1.id
  }
  lines {
    line_code = "default"
  }
}