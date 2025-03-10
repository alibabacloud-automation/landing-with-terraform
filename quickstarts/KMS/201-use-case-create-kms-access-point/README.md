## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建KMS应用接入点，涉及到网络控制规则,应用接入点的资源定义,应用身份凭证资源定义,访问控制策略等资源的创建。
详情可查看[通过Terraform创建KMS应用接入点](https://help.aliyun.com/document_detail/2572878.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create an KMS AAP on Alibaba Cloud, which involves the creation of resources such as network rule, application access point, client key and access control policy.
More details in [Create an KMS AAP](https://help.aliyun.com/document_detail/2572878.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_kms_application_access_point.application_access_point_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_application_access_point) | resource |
| [alicloud_kms_client_key.client_key](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_client_key) | resource |
| [alicloud_kms_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_instance) | resource |
| [alicloud_kms_network_rule.network_rule_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_network_rule) | resource |
| [alicloud_kms_policy.policy_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_policy) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [local_file.ca_certificate_chain_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"tf-kms-vpc-172-16"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ecs.n1.tiny"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create KMS access point](https://help.aliyun.com/document_detail/2572878.html) 

<!-- docs-link --> 