## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个HBase集群。
详情可查看[通过Terraform创建HBase集群](https://help.aliyun.com/document_detail/2841890.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create HBase instance on Alibaba Cloud.
More details in [Create HBase instance](https://help.aliyun.com/document_detail/2841890.html).
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
| [alicloud_hbase_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/hbase_instance) | resource |
| [alicloud_vpc.vpc1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_hbase_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/hbase_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"hbase.sn2.large"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"hbasetest"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-qingdao"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create HBase instance](https://help.aliyun.com/document_detail/2841890.html) 

<!-- docs-link --> 