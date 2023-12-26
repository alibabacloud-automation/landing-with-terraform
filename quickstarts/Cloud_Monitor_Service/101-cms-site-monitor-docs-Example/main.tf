resource "alicloud_cms_site_monitor" "basic" {
  address   = "http://www.alibabacloud.com"
  task_name = "tf-example"
  task_type = "HTTP"
  interval  = 5
  isp_cities {
    city = "546"
    isp  = "465"
  }
  options_json = <<EOT
{
    "http_method": "get",
    "waitTime_after_completion": null,
    "ipv6_task": false,
    "diagnosis_ping": false,
    "diagnosis_mtr": false,
    "assertions": [
        {
            "operator": "lessThan",
            "type": "response_time",
            "target": 1000
        }
    ],
    "time_out": 30000
}
EOT
}