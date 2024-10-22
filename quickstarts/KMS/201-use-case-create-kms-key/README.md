## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建并管理KMS密钥，涉及到KMS软件密钥管理实例,应用身份凭据，密钥别名等资源的创建与管理。
详情可查看[通过Terraform创建KMS密钥](http://help.aliyun.com/document_detail/2572879.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create and manage KMS keys on Alibaba Cloud, which involves the creation and management of resources such as KMS instance, key and key alias.
More details in [Create KMS key](http://help.aliyun.com/document_detail/2572879.htm).
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
| [alicloud_kms_alias.kms_software_key_encrypt_decrypt_alias](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_alias) | resource |
| [alicloud_kms_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_instance) | resource |
| [alicloud_kms_key.kms_software_key_encrypt_decrypt](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_key) | resource |
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
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shanghai"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create KMS key](http://help.aliyun.com/document_detail/2572879.htm) 

<!-- docs-link --> 