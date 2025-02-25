## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上开通云安全中心资源。
详情可查看[通过Terraform快速开通云安全中心](https://help.aliyun.com/zh/security-center/use-cases/activate-security-center-in-a-quick-manner-by-using-terraform)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to activate Security Center on Alibaba Cloud.
More details in [Activate Security Center](https://help.aliyun.com/zh/security-center/use-cases/activate-security-center-in-a-quick-manner-by-using-terraform).
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
| [alicloud_threat_detection_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/threat_detection_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_buy_number"></a> [buy\_number](#input\_buy\_number) | 购买的服务器数量，默认值为"30" | `string` | `"30"` | no |
| <a name="input_container_image_scan"></a> [container\_image\_scan](#input\_container\_image\_scan) | 容器镜像安全扫描次数，默认值为"30" | `string` | `"30"` | no |
| <a name="input_container_image_scan_new"></a> [container\_image\_scan\_new](#input\_container\_image\_scan\_new) | 容器镜像安全扫描注意：步长为20，即只能填写20的倍数 | `string` | `"100"` | no |
| <a name="input_honeypot"></a> [honeypot](#input\_honeypot) | 云蜜罐许可证数量，默认值为"32" | `string` | `"32"` | no |
| <a name="input_honeypot_switch"></a> [honeypot\_switch](#input\_honeypot\_switch) | 云蜜罐开关，默认值为"1"(是) | `string` | `"1"` | no |
| <a name="input_name"></a> [name](#input\_name) | 定义资源名称，默认值为"terraform-example" | `string` | `"terraform-example"` | no |
| <a name="input_payment_type"></a> [payment\_type](#input\_payment\_type) | 支付类型，默认值为"Subscription"(订阅) | `string` | `"Subscription"` | no |
| <a name="input_period"></a> [period](#input\_period) | 预付费周期，默认值为"1"(单位：月) | `string` | `"1"` | no |
| <a name="input_renewal_status"></a> [renewal\_status](#input\_renewal\_status) | 自动续订状态，默认值为"ManualRenewal"(手动续订) | `string` | `"ManualRenewal"` | no |
| <a name="input_sas_anti_ransomware"></a> [sas\_anti\_ransomware](#input\_sas\_anti\_ransomware) | 反勒索软件容量，默认值为"100"(单位：GB) | `string` | `"100"` | no |
| <a name="input_sas_sdk"></a> [sas\_sdk](#input\_sas\_sdk) | 恶意文件检测数量，默认值为"1000"(单位：10,000次) | `string` | `"1000"` | no |
| <a name="input_sas_sdk_switch"></a> [sas\_sdk\_switch](#input\_sas\_sdk\_switch) | 恶意文件检测SDK开关，默认值为"1"(是) | `string` | `"1"` | no |
| <a name="input_sas_sls_storage"></a> [sas\_sls\_storage](#input\_sas\_sls\_storage) | 日志分析存储容量，默认值为"100"(单位：GB) | `string` | `"100"` | no |
| <a name="input_sas_webguard_boolean"></a> [sas\_webguard\_boolean](#input\_sas\_webguard\_boolean) | 网页防篡改开关，默认值为"1"(是) | `string` | `"1"` | no |
| <a name="input_sas_webguard_order_num"></a> [sas\_webguard\_order\_num](#input\_sas\_webguard\_order\_num) | 防篡改授权数量，默认值为"100" | `string` | `"100"` | no |
| <a name="input_version_code"></a> [version\_code](#input\_version\_code) | 版本代码，默认值为"level2"(企业版) | `string` | `"level2"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Activate Security Center](https://help.aliyun.com/zh/security-center/use-cases/activate-security-center-in-a-quick-manner-by-using-terraform) 

<!-- docs-link --> 