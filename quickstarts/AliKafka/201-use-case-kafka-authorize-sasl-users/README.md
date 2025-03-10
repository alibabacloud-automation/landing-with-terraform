## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上的云消息队列 Kafka 版的专业版实例使用访问控制列表（ACL）来管理SASL用户对主题和消费组的访问权限，涉及到SASL用户及权限的创建及查询。
详情可查看[通过 Terraform 为Kafka SASL用户授权](https://help.aliyun.com/document_detail/2618406.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use ApsaraMQ for Kafka Professional Edition instances access control lists (ACLs) to manage the permissions of Simple Authentication and Security Layer (SASL) users on topics and consumer groups on Alibaba Cloud, which involves the creation and query of SASL users and permissions.
More details in [Kafka authorize SASL users](https://help.aliyun.com/document_detail/2618406.html).
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
| [alicloud_alikafka_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_instance) | resource |
| [alicloud_alikafka_sasl_acl.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_sasl_acl) | resource |
| [alicloud_alikafka_sasl_user.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_sasl_user) | resource |
| [alicloud_alikafka_topic.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_topic) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_alikafka_sasl_acls.sasl_acls_ds](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/alikafka_sasl_acls) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shenzhen-f"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Kafka authorize SASL users](https://help.aliyun.com/document_detail/2618406.html) 

<!-- docs-link --> 