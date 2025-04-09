## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建配置审计规则与函数计算3.0，实现对不合规安全组规则的自动修复。
本示例来自[对安全组规则的合规性进行自动审计修复](https://help.aliyun.com/document_detail/389066.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use Cloud Config and Function Compute to automatically audit the compliance of security group rules on Alibaba Cloud.
This example is from [Automatically audit the compliance of security group rules](https://help.aliyun.com/document_detail/389066.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_config_remediation.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/config_remediation) | resource |
| [alicloud_config_rule.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/config_rule) | resource |
| [alicloud_fcv3_function.fc_function](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fcv3_function) | resource |
| [alicloud_ram_policy.policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_role.role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [local_file.python_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.requirements_txt](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.upload_code](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [archive_file.code_package](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [local_file.base64_encoded_code](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-shenzhen"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Automatically audit the compliance of security group rules](https://help.aliyun.com/document_detail/389066.html) 

<!-- docs-link --> 