# ------------------------------------------------------------------------------
# 模块输出值
#
# 本文件定义了模块执行成功后返回给调用方的值。
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户。
# ------------------------------------------------------------------------------

# 输出Elasticsearch实例的详情地址
output "elasticsearch_address" {
  description = "Elasticsearch 实例详情地址"
  value = format("https://elasticsearch.console.aliyun.com/%s/instances/%s/base", data.alicloud_regions.current_region_ds.regions.0.id, alicloud_elasticsearch_instance.elasticsearch.id)
}

# 输出Elasticsearch实例的访问密码
output "elasticsearch_password" {
  sensitive   = true
  value       = var.elasticsearch_password
  description = "Elasticsearch 实例密码"
}

# 输出Elasticsearch实例的Kibana地址
output "kibana_domain" {
  value       = alicloud_elasticsearch_instance.elasticsearch.kibana_domain
  description = "Elasticsearch 实例的 Kibana 地址"
}

# 输出Elasticsearch实例的ID
output "instance_id" {
  value       = alicloud_elasticsearch_instance.elasticsearch.id
  description = "Elasticsearch 实例的ID"
}