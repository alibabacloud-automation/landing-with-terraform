## Introduction

This example is used to create a `alicloud_oss_bucket_replication` resource.

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
| [alicloud_kms_key.key](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_key) | resource |
| [alicloud_oss_bucket.bucket_dest](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_oss_bucket.bucket_src](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_oss_bucket_replication.cross-region-replication](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_replication) | resource |
| [alicloud_ram_policy.policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_role.role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

No inputs.
<!-- END_TF_DOCS -->    