## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建NAT网关实例。
详情可查看[使用Terraform创建NAT网关实例](https://help.aliyun.com/document_detail/2844821.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create NAT gateway instance on Alibaba Cloud.
More details in [Create NAT Gateway](https://help.aliyun.com/document_detail/2844821.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_nat_gateway.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nat_gateway) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_enhanced_nat_available_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/enhanced_nat_available_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create NAT Gateway](https://help.aliyun.com/document_detail/2844821.html) 

<!-- docs-link --> 