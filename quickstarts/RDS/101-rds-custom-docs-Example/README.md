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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | n/a | `string` | `"c18c40b2b336840e2b2bbf8ab291758e2"` | no |
| <a name="input_deploymentsetid"></a> [deploymentsetid](#input\_deploymentsetid) | n/a | `string` | `"ds-2ze78ef5kyj9eveue92m"` | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `"ran_1-08_rccreatenodepool_api"` | no |
| <a name="input_example_region_id"></a> [example\_region\_id](#input\_example\_region\_id) | n/a | `string` | `"cn-beijing"` | no |
| <a name="input_example_zone_id"></a> [example\_zone\_id](#input\_example\_zone\_id) | n/a | `string` | `"cn-beijing-h"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_securitygroup_name"></a> [securitygroup\_name](#input\_securitygroup\_name) | n/a | `string` | `"rds_custom_init_sg_cn_beijing"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | `"beijing111"` | no |
| <a name="input_vswtich-id"></a> [vswtich-id](#input\_vswtich-id) | n/a | `string` | `"example_vswitch"` | no |
<!-- END_TF_DOCS -->
