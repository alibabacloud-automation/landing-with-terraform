## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上配置Logtail采集，涉及到Logtail配置与应用Logtail采集配置到机器组。
详情可查看[通过Terraform配置SLS Logtail采集](https://help.aliyun.com/document_detail/2713316.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a Logtail configuration on Alibaba Cloud, which involves the Logtail configuration and attachment.
More details in [Use Terraform to create a SLS Logtail configuration](https://help.aliyun.com/document_detail/2713316.html).
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
| [alicloud_log_machine_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_machine_group) | resource |
| [alicloud_log_project.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_log_store.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_store) | resource |
| [alicloud_logtail_attachment.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/logtail_attachment) | resource |
| [alicloud_logtail_config.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/logtail_config) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_identify_list"></a> [identify\_list](#input\_identify\_list) | 机器组包含的机器IP | `list(string)` | <pre>[<br/>  "10.0.0.1",<br/>  "10.0.0.2"<br/>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Configure SLS Logtail](https://help.aliyun.com/document_detail/2713316.html) 

<!-- docs-link --> 