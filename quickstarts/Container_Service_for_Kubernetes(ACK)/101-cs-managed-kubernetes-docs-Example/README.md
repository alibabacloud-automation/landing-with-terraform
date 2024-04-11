## Introduction

This example is used to create a `alicloud_cs_managed_kubernetes` resource.

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
| [alicloud_cs_managed_kubernetes.k8s](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_managed_kubernetes) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.terway_vswitches](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitches](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_enhanced_nat_available_zones.enhanced](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/enhanced_nat_available_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_addons"></a> [cluster\_addons](#input\_cluster\_addons) | n/a | <pre>list(object({<br>    name   = string<br>    config = string<br>  }))</pre> | <pre>[<br>  {<br>    "config": "",<br>    "name": "terway-eniip"<br>  },<br>  {<br>    "config": "",<br>    "name": "csi-plugin"<br>  },<br>  {<br>    "config": "",<br>    "name": "csi-provisioner"<br>  },<br>  {<br>    "config": "{'IngressDashboardEnabled':'true'}",<br>    "name": "logtail-ds"<br>  },<br>  {<br>    "config": "{'IngressSlbNetworkType':'internet'}",<br>    "name": "nginx-ingress-controller"<br>  },<br>  {<br>    "config": "",<br>    "name": "arms-prometheus"<br>  },<br>  {<br>    "config": "{'sls_project_name':''}",<br>    "name": "ack-node-problem-detector"<br>  }<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
| <a name="input_node_cidr_mask"></a> [node\_cidr\_mask](#input\_node\_cidr\_mask) | The node cidr block to specific how many pods can run on single node. | `number` | `24` | no |
| <a name="input_proxy_mode"></a> [proxy\_mode](#input\_proxy\_mode) | Proxy mode is option of kube-proxy. | `string` | `"ipvs"` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | The kubernetes service cidr block. It cannot be equals to vpc's or vswitch's or pod's and cannot be in them. | `string` | `"192.168.0.0/16"` | no |
| <a name="input_terway_vswitch_cidrs"></a> [terway\_vswitch\_cidrs](#input\_terway\_vswitch\_cidrs) | List of cidr blocks used to create several new vswitches when 'terway\_vswitch\_cidrs' is not specified. | `list(string)` | <pre>[<br>  "10.4.0.0/16",<br>  "10.5.0.0/16"<br>]</pre> | no |
| <a name="input_terway_vswitch_ids"></a> [terway\_vswitch\_ids](#input\_terway\_vswitch\_ids) | List of existing vswitch ids for terway. | `list(string)` | `[]` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The cidr block used to launch a new vpc when 'vpc\_id' is not specified. | `string` | `"10.0.0.0/8"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Existing vpc id used to create several vswitches and other resources. | `string` | `""` | no |
| <a name="input_vswitch_cidrs"></a> [vswitch\_cidrs](#input\_vswitch\_cidrs) | List of cidr blocks used to create several new vswitches when 'vswitch\_ids' is not specified. | `list(string)` | <pre>[<br>  "10.1.0.0/16",<br>  "10.2.0.0/16"<br>]</pre> | no |
| <a name="input_vswitch_ids"></a> [vswitch\_ids](#input\_vswitch\_ids) | List of existing vswitch id. | `list(string)` | `[]` | no |
<!-- END_TF_DOCS -->    