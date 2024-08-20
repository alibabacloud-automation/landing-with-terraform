## Introduction

This example is used to create a `alicloud_governance_baseline` resource.

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
| [alicloud_governance_baseline.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/governance_baseline) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_baseline_name"></a> [baseline\_name](#input\_baseline\_name) | n/a | `string` | `"tf-auto-example-baseline"` | no |
| <a name="input_baseline_name_update"></a> [baseline\_name\_update](#input\_baseline\_name\_update) | n/a | `string` | `"tf-auto-example-baseline-update"` | no |
| <a name="input_item_password_policy"></a> [item\_password\_policy](#input\_item\_password\_policy) | n/a | `string` | `"ACS-BP_ACCOUNT_FACTORY_RAM_USER_PASSWORD_POLICY"` | no |
| <a name="input_item_ram_security"></a> [item\_ram\_security](#input\_item\_ram\_security) | n/a | `string` | `"ACS-BP_ACCOUNT_FACTORY_RAM_SECURITY_PREFERENCE"` | no |
| <a name="input_item_services"></a> [item\_services](#input\_item\_services) | n/a | `string` | `"ACS-BP_ACCOUNT_FACTORY_SUBSCRIBE_SERVICES"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->
