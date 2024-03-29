provider "alicloud" {
  region = "cn-shanghai"
}
data "alicloud_chatbot_agents" "default" {}
resource "alicloud_chatbot_publish_task" "default" {
  biz_type  = "faq"
  agent_key = data.alicloud_chatbot_agents.default.agents.0.agent_key
}