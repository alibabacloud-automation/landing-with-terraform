## Introduction

This example is used to create a `alicloud_rds_custom` resource.

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
| [alicloud_ecs_deployment_set.deploymentSet](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_deployment_set) | resource |
| [alicloud_ecs_key_pair.KeyPairName](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_key_pair) | resource |
| [alicloud_rds_custom.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_custom) | resource |
| [alicloud_security_group.securityGroupId](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.vpcId](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vSwitchId](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |
| [alicloud_vpcs.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpcs) | data source |
| [alicloud_vswitches.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vswitches) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_example_zone_id"></a> [example\_zone\_id](#input\_example\_zone\_id) | n/a | `string` | `"cn-chengdu-b"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->
