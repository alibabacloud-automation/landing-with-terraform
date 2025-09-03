output "rabbitmq_detail_address" {
  description = "RabbitMQ实例详情页。"
  value       = format("https://amqp.console.aliyun.com/region/%s/instance/%s/instance-detail", var.region, alicloud_amqp_instance.default.id)
}