## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[文件下载加速及成本优化](https://www.aliyun.com/solution/tech-solution/fdaaco), 涉及到内容分发网络（CDN）、云解析（DNS）、对象存储服务（OSS）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [File Download Acceleration and Cost Optimization](https://www.aliyun.com/solution/tech-solution/fdaaco), which involves the creation and deployment of resources such as Content Delivery Network (CDN), Alibaba Cloud DNS, Object Storage Service (OSS).
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
| [alicloud_cdn_domain_config.domain_config1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cdn_domain_config) | resource |
| [alicloud_cdn_domain_config.domain_config2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cdn_domain_config) | resource |
| [alicloud_cdn_domain_config.domain_config3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cdn_domain_config) | resource |
| [alicloud_cdn_domain_new.domain](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cdn_domain_new) | resource |
| [alicloud_dns_record.domain_record](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dns_record) | resource |
| [alicloud_oss_bucket.oss_bucket](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_ram_policy.policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_role.role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_cdn_service.open_cdn](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cdn_service) | data source |
| [alicloud_oss_service.open_oss](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/oss_service) | data source |
| [alicloud_ram_roles.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_roles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name_prefix"></a> [bucket\_name\_prefix](#input\_bucket\_name\_prefix) | 存储空间名称前缀，长度为3~63个字符，必须以小写字母或数字开头和结尾，可以包含小写字母、数字和连字符(-)。需要全网唯一性，已经存在的不能在创建。 | `string` | `"bucket-example"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | 域名（当前阿里云账号下已备案的域名，不包含前缀） | `string` | n/a | yes |
| <a name="input_domain_prefix"></a> [domain\_prefix](#input\_domain\_prefix) | 域名前缀 | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | 选择加速区域。加速区域为仅中国内地和全球时，服务域名必须备案。 | `string` | `"domestic"` | no |
<!-- END_TF_DOCS -->