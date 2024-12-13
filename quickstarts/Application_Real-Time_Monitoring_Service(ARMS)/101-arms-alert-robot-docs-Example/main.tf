resource "alicloud_arms_alert_robot" "wechat" {
  alert_robot_name = "example_wechat"
  robot_type       = "wechat"
  robot_addr       = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=1c704e23"
  daily_noc        = true
  daily_noc_time   = "09:30,17:00"
}

resource "alicloud_arms_alert_robot" "dingding" {
  alert_robot_name = "example_dingding"
  robot_type       = "dingding"
  robot_addr       = "https://oapi.dingtalk.com/robot/send?access_token=1c704e23"
  daily_noc        = true
  daily_noc_time   = "09:30,17:00"
}

resource "alicloud_arms_alert_robot" "feishu" {
  alert_robot_name = "example_feishu"
  robot_type       = "feishu"
  robot_addr       = "https://open.feishu.cn/open-apis/bot/v2/hook/a48efa01"
  daily_noc        = true
  daily_noc_time   = "09:30,17:00"
}