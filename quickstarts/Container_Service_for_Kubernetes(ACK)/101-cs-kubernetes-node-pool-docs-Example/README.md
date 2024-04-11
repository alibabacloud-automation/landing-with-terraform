## Introduction

This example is used to create a `alicloud_cs_kubernetes_node_pool` resource.

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
| [alicloud_cs_kubernetes_node_pool.customized_kubelet](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_kubernetes_node_pool.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_kubernetes_node_pool.desired_size](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_kubernetes_node_pool.maintenance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_kubernetes_node_pool.prepaid_node](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_kubernetes_node_pool.spot_auto_scaling](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_kubernetes_node_pool.spot_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_managed_kubernetes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_managed_kubernetes) | resource |
| [alicloud_key_pair.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/key_pair) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_enhanced_nat_available_zones.enhanced](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/enhanced_nat_available_zones) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    