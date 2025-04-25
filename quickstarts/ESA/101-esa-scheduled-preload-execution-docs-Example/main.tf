data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "default" {
  site_name   = "terraform.cn"
  instance_id = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_scheduled_preload_job" "default" {
  insert_way                 = "textBox"
  site_id                    = alicloud_esa_site.default.id
  scheduled_preload_job_name = "example_scheduledpreloadexecution_job"
  url_list                   = "http://example.gositecdn.cn/example/example.txt"
}

resource "alicloud_esa_scheduled_preload_execution" "default" {
  slice_len                = "5"
  end_time                 = "2024-06-04T10:02:09.000+08:00"
  start_time               = "2024-06-04T00:00:00.000+08:00"
  scheduled_preload_job_id = alicloud_esa_scheduled_preload_job.default.scheduled_preload_job_id
  interval                 = "30"
}