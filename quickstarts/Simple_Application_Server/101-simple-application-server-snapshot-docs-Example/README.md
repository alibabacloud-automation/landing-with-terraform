## Introduction

This example is used to create a `alicloud_simple_application_server_snapshot` resource.

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
| [alicloud_simple_application_server_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/simple_application_server_instance) | resource |
| [alicloud_simple_application_server_snapshot.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/simple_application_server_snapshot) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_simple_application_server_disks.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/simple_application_server_disks) | data source |
| [alicloud_simple_application_server_images.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/simple_application_server_images) | data source |
| [alicloud_simple_application_server_plans.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/simple_application_server_plans) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
<!-- END_TF_DOCS -->
