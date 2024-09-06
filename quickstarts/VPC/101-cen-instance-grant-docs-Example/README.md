## Introduction

This example is used to create a `alicloud_cen_instance_grant` resource.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_alicloud.child_account"></a> [alicloud.child\_account](#provider\_alicloud.child\_account) | n/a |
| <a name="provider_alicloud.your_account"></a> [alicloud.your\_account](#provider\_alicloud.your\_account) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_instance.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_instance_grant.child_account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance_grant) | resource |
| [alicloud_vpc.child_account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_account.child_account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_account.your_account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_another_uid"></a> [another\_uid](#input\_another\_uid) | n/a | `string` | `"xxxx"` | no |
<!-- END_TF_DOCS -->    