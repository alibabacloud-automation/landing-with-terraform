## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个轻量应用服务器实例。
详情可查看[使用Terraform创建轻量应用服务器实例](https://help.aliyun.com/zh/simple-application-server/developer-reference/using-terraform-to-use-simple-application-server)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a Simple Application Server instance on Alibaba Cloud.
More details in [Create Simple Application Server](https://help.aliyun.com/zh/simple-application-server/developer-reference/using-terraform-to-use-simple-application-server).
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
| [alicloud_simple_application_server_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/simple_application_server_instance) | resource |
| [alicloud_simple_application_server_images.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/simple_application_server_images) | data source |
| [alicloud_simple_application_server_plans.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/simple_application_server_plans) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create Simple Application Server](https://help.aliyun.com/zh/simple-application-server/developer-reference/using-terraform-to-use-simple-application-server) 

<!-- docs-link --> 