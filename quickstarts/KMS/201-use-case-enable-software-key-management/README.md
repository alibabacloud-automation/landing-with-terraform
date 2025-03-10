## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上购买并启用KMS软件密钥管理实例。
详情可查看[通过Terraform购买并启用软件密钥管理实例](https://help.aliyun.com/document_detail/2572877.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to purchase and enable an instance of the software key management type on Alibaba Cloud.
More details in [Purchase and enable an instance of the software key management type](https://help.aliyun.com/document_detail/2572877.html).
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
| [alicloud_kms_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_instance) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [local_file.ca_certificate_chain_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"tff-kms-vpc-172-16"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ecs.n1.tiny"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shanghai"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Enable software key management](https://help.aliyun.com/document_detail/2572877.html) 

<!-- docs-link --> 