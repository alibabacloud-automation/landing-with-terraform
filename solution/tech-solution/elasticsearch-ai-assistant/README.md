## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[Elasticsearch 智能运维 AI 助手](https://www.aliyun.com/solution/tech-solution/elasticsearch-ai-assistant)，涉及专有网络（VPC）、交换机（VSwitch）、检索分析服务 Elasticsearch（Elasticsearch）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Elasticsearch AI Assistant for intelligent O&M](https://www.aliyun.com/solution/tech-solution/elasticsearch-ai-assistant), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), Alibaba Cloud Elasticsearch(Elasticsearch).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_elasticsearch_instance.elasticsearch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/elasticsearch_instance) | resource |
| [alicloud_vpc.ecs_vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.ecsvswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_elasticsearch_zones.zones_ids](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/elasticsearch_zones) | data source |
| [alicloud_regions.current_region_ds](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_elasticsearch_password"></a> [elasticsearch\_password](#input\_elasticsearch\_password) | elasticsearch\_password | `string` | n/a | yes |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | Kibana 公网访问白名单 IP，访问 https://ipinfo.io/ip 查看当前公网 IP | `string` | n/a | yes |
<!-- END_TF_DOCS -->