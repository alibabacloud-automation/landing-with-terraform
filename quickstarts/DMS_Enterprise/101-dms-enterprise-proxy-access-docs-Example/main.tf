data "alicloud_dms_enterprise_users" "dms_enterprise_users_ds" {
  role   = "USER"
  status = "NORMAL"
}
data "alicloud_dms_enterprise_proxies" "ids" {}

resource "alicloud_dms_enterprise_proxy_access" "default" {
  proxy_id = data.alicloud_dms_enterprise_proxies.ids.proxies.0.id
  user_id  = data.alicloud_dms_enterprise_users.dms_enterprise_users_ds.users.0.user_id
}