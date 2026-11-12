## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上添加云防火墙成员账号。
详情可查看[通过Terraform添加云防火墙成员账号](http://help.aliyun.com/document_detail/2245590.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to add a member to Cloud Firewall  on Alibaba Cloud.
More details in [Add a member to Cloud Firewall](http://help.aliyun.com/document_detail/2245590.htm).
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
| [alicloud_cloud_firewall_instance_member.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_firewall_instance_member) | resource |
| [alicloud_resource_manager_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_account) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_resource_manager_folders.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_folders) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | n/a | `string` | `"EAccount"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Add a member to cloud firewall](http://help.aliyun.com/document_detail/2245590.htm) 

<!-- docs-link --> 