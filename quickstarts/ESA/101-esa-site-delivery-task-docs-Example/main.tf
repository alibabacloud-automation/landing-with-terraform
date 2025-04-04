variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "resource_Site_http_example" {
  site_name   = "chenxin0116.site"
  instance_id = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_site_delivery_task" "default" {
  http_delivery {
    standard_auth_param {
      private_key  = "***"
      url_path     = "v1/log/upload"
      expired_time = "300"
    }

    transform_timeout = "10"
    max_retry         = "3"
    max_batch_mb      = "5"
    compress          = "gzip"
    log_body_suffix   = "cdnVersion:1.0"
    standard_auth_on  = "false"
    log_body_prefix   = "cdnVersion:1.0"
    dest_url          = "http://11.177.129.13:8081"
    max_batch_size    = "1000"
  }

  data_center   = "oversea"
  discard_rate  = "0.0"
  task_name     = "dcdn-example-task"
  business_type = "dcdn_log_access_l1"
  field_name    = "ConsoleLog,CPUTime,Duration,ErrorCode,ErrorMessage,ResponseSize,ResponseStatus,RoutineName,ClientRequestID,LogTimestamp,FetchStatus,SubRequestID"
  delivery_type = "http"
  site_id       = alicloud_esa_site.resource_Site_http_example.id
}