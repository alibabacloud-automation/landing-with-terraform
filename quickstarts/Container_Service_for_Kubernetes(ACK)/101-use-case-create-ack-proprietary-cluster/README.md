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
| [alicloud_cs_kubernetes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.terway_vswitches](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitches](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_enhanced_nat_available_zones.enhanced](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/enhanced_nat_available_zones) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_addons"></a> [cluster\_addons](#input\_cluster\_addons) | 指定ACK集群安装的组件。声明每个组件的名称和对应配置。 | <pre>list(object({<br/>    name   = string<br/>    config = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "config": "",<br/>    "name": "terway-eniip"<br/>  },<br/>  {<br/>    "config": "",<br/>    "name": "csi-plugin"<br/>  },<br/>  {<br/>    "config": "",<br/>    "name": "csi-provisioner"<br/>  },<br/>  {<br/>    "config": "{\"IngressDashboardEnabled\":\"true\"}",<br/>    "name": "logtail-ds"<br/>  },<br/>  {<br/>    "config": "{\"IngressSlbNetworkType\":\"internet\"}",<br/>    "name": "nginx-ingress-controller"<br/>  },<br/>  {<br/>    "config": "",<br/>    "name": "arms-prometheus"<br/>  },<br/>  {<br/>    "config": "{\"sls_project_name\":\"\"}",<br/>    "name": "ack-node-problem-detector"<br/>  }<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | 定义资源的名称或标签。 | `string` | `"tf-example"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-hangzhou"` | no |
| <a name="input_terway_vswitch_cidrs"></a> [terway\_vswitch\_cidrs](#input\_terway\_vswitch\_cidrs) | List of cidr blocks used to create several new vswitches when 'terway\_vswitch\_cidrs' is not specified. | `list(string)` | <pre>[<br/>  "10.4.0.0/16",<br/>  "10.5.0.0/16",<br/>  "10.6.0.0/16"<br/>]</pre> | no |
| <a name="input_terway_vswitch_ids"></a> [terway\_vswitch\_ids](#input\_terway\_vswitch\_ids) | List of existing vswitch ids for terway. | `list(string)` | `[]` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The cidr block used to launch a new vpc when 'vpc\_id' is not specified. | `string` | `"10.0.0.0/8"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Existing vpc id used to create several vswitches and other resources. | `string` | `""` | no |
| <a name="input_vswitch_cidrs"></a> [vswitch\_cidrs](#input\_vswitch\_cidrs) | List of cidr blocks used to create several new vswitches when 'vswitch\_ids' is not specified. | `list(string)` | <pre>[<br/>  "10.1.0.0/16",<br/>  "10.2.0.0/16",<br/>  "10.3.0.0/16"<br/>]</pre> | no |
| <a name="input_vswitch_ids"></a> [vswitch\_ids](#input\_vswitch\_ids) | List of existing vswitch id. | `list(string)` | `[]` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create ACK proprietary cluster](http://help.aliyun.com/document_detail/2674339.htm) 

<!-- docs-link --> 