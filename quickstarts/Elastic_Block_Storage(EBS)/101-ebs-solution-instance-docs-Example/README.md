## Introduction

This example is used to create a `alicloud_ebs_solution_instance` resource.

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
| [alicloud_ebs_solution_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ebs_solution_instance) | resource |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shanghai-l"` | no |
<!-- END_TF_DOCS -->    