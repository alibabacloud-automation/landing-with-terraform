## Introduction

This example is used to create a `alicloud_cs_kubernetes_policy_instance` resource.

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
| [alicloud_cs_kubernetes_policy_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_policy_instance) | resource |
| [alicloud_cs_managed_kubernetes.CreateCluster](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_managed_kubernetes) | resource |
| [alicloud_vpc.CreateVPC](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.CreateVSwitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_enhanced_nat_available_zones.enhanced](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/enhanced_nat_available_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | `"example-create-cluster"` | no |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | n/a | `string` | `"172.16.0.0/16"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | n/a | `string` | `"ACKPSPHostNetworkingPorts"` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | n/a | `string` | `"192.168.0.0/16"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | `"10.0.0.0/8"` | no |
| <a name="input_vswitch_cidrs"></a> [vswitch\_cidrs](#input\_vswitch\_cidrs) | n/a | `list(string)` | <pre>[<br/>  "10.1.0.0/16",<br/>  "10.2.0.0/16"<br/>]</pre> | no |
<!-- END_TF_DOCS -->
