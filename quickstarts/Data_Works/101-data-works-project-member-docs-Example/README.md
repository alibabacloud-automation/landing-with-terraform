## Introduction

This example is used to create a `alicloud_data_works_project_member` resource.

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
| [alicloud_data_works_project.defaultQeRfvU](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/data_works_project) | resource |
| [alicloud_data_works_project_member.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/data_works_project_member) | resource |
| [alicloud_ram_user.defaultKCTrB2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user) | resource |
| [random_integer.randint](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_code"></a> [admin\_code](#input\_admin\_code) | n/a | `string` | `"role_project_admin"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
<!-- END_TF_DOCS -->
