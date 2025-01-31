## Introduction

This example is used to create a `alicloud_max_compute_role_user_attachment` resource.

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
| [alicloud_max_compute_role_user_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/max_compute_role_user_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aliyun_user"></a> [aliyun\_user](#input\_aliyun\_user) | n/a | `string` | `"ALIYUN$openapiautomation@test.aliyunid.com"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | `"default_project_669886c"` | no |
| <a name="input_ram_role"></a> [ram\_role](#input\_ram\_role) | n/a | `string` | `"RAM$openapiautomation@test.aliyunid.com:role/terraform-no-ak-assumerole-no-deleting"` | no |
| <a name="input_ram_user"></a> [ram\_user](#input\_ram\_user) | n/a | `string` | `"RAM$openapiautomation@test.aliyunid.com:tf-example"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | n/a | `string` | `"role_project_admin"` | no |
<!-- END_TF_DOCS -->
