## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上购买DDoS高防实例。
详情可查看[通过Terraform购买并管理DDoS高防实例](http://help.aliyun.com/document_detail/2527816.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to purchase and manage an Anti-DDoS Pro or Anti-DDoS Premium instance on Alibaba Cloud.
More details in [Manage an Anti-DDoS instance](http://help.aliyun.com/document_detail/2527816.htm).
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
| [alicloud_ddoscoo_instance.newInstance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddoscoo_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Bandwidth of the DDoS CoO instance | `string` | `"40"` | no |
| <a name="input_base_bandwidth"></a> [base\_bandwidth](#input\_base\_bandwidth) | Base bandwidth of the DDoS CoO instance | `string` | `"30"` | no |
| <a name="input_ddoscoo_instance_name"></a> [ddoscoo\_instance\_name](#input\_ddoscoo\_instance\_name) | The name of the DDoS CoO instance | `string` | `"Ddoscoo"` | no |
| <a name="input_domain_count"></a> [domain\_count](#input\_domain\_count) | Number of domains for the DDoS CoO instance | `string` | `"50"` | no |
| <a name="input_period"></a> [period](#input\_period) | Purchase period of the DDoS CoO instance | `string` | `"1"` | no |
| <a name="input_port_count"></a> [port\_count](#input\_port\_count) | Number of ports for the DDoS CoO instance | `string` | `"50"` | no |
| <a name="input_pricing_mode"></a> [pricing\_mode](#input\_pricing\_mode) | Pricing mode of the DDoS CoO instance (Prepaid or Postpaid) | `string` | `"Postpaid"` | no |
| <a name="input_product_type"></a> [product\_type](#input\_product\_type) | Product type of the DDoS CoO instance | `string` | `"ddoscoo"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | 区域 | `string` | `"cn-hangzhou"` | no |
| <a name="input_service_bandwidth"></a> [service\_bandwidth](#input\_service\_bandwidth) | Service bandwidth of the DDoS CoO instance | `string` | `"100"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Anti DDoS instance management](http://help.aliyun.com/document_detail/2527816.htm) 

<!-- docs-link --> 