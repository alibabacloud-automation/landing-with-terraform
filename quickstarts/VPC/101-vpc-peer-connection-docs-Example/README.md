## Introduction

This example is used to create a `alicloud_vpc_peer_connection` resource.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_alicloud.accepting"></a> [alicloud.accepting](#provider\_alicloud.accepting) | n/a |
| <a name="provider_alicloud.local"></a> [alicloud.local](#provider\_alicloud.local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_vpc.accepting_vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.local_vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_peer_connection.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_peer_connection) | resource |
| [alicloud_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accepting_region"></a> [accepting\_region](#input\_accepting\_region) | n/a | `string` | `"cn-beijing"` | no |
<!-- END_TF_DOCS -->    