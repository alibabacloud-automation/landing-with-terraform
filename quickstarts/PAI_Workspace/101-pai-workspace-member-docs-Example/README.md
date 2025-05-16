## Introduction

This example is used to create a `alicloud_pai_workspace_member` resource.

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
| [alicloud_pai_workspace_member.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/pai_workspace_member) | resource |
| [alicloud_pai_workspace_workspace.Workspace](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/pai_workspace_workspace) | resource |
| [alicloud_ram_user.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform_example"` | no |
<!-- END_TF_DOCS -->
