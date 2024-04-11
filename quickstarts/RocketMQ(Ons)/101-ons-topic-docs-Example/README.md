## Introduction

This example is used to create a `alicloud_ons_topic` resource.

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
| [alicloud_ons_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ons_instance) | resource |
| [alicloud_ons_topic.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ons_topic) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"onsInstanceName"` | no |
| <a name="input_topic"></a> [topic](#input\_topic) | n/a | `string` | `"onsTopicName"` | no |
<!-- END_TF_DOCS -->    