## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上为ACK节点池指定部署集，涉及到ACK专有集群，部署集，节点池等资源的创建。
详情可查看[使用Terraform为ACK节点池指定部署集](http://help.aliyun.com/document_detail/391261.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to associate a deployment set with a node pool on Alibaba Cloud, which involves the creation of resources such as ACK dedicated cluster, deployment set and node pool.
More details in [Use Terraform to associate a deployment set with a ACK node pool](http://help.aliyun.com/document_detail/391261.htm).
<!-- DOCS_DESCRIPTION_EN -->

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
| [alicloud_cs_kubernetes_node_pool.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_managed_kubernetes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_managed_kubernetes) | resource |
| [alicloud_ecs_deployment_set.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_deployment_set) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.terway_vswitches](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitches](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ack_version"></a> [ack\_version](#input\_ack\_version) | Desired Kubernetes version. | `string` | `"1.28.9-aliyun.1"` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The availability zones of vswitches. | `list` | <pre>[<br/>  "cn-shenzhen-c",<br/>  "cn-shenzhen-e",<br/>  "cn-shenzhen-f"<br/>]</pre> | no |
| <a name="input_cluster_addons"></a> [cluster\_addons](#input\_cluster\_addons) | 指定ACK集群安装的组件。包括Terway（网络组件）、csi-plugin（存储组件）、csi-provisioner（存储组件）、logtail-ds（日志组件）、Nginx Ingress Controller、ack-arms-prometheus（监控组件）以及ack-node-problem-detector（节点诊断组件）。 | <pre>list(object({<br/>    name   = string<br/>    config = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "config": "",<br/>    "name": "terway-eniip"<br/>  },<br/>  {<br/>    "config": "{\"IngressDashboardEnabled\":\"true\"}",<br/>    "name": "logtail-ds"<br/>  },<br/>  {<br/>    "config": "{\"IngressSlbNetworkType\":\"internet\"}",<br/>    "name": "nginx-ingress-controller"<br/>  },<br/>  {<br/>    "config": "",<br/>    "name": "arms-prometheus"<br/>  },<br/>  {<br/>    "config": "{\"sls_project_name\":\"\"}",<br/>    "name": "ack-node-problem-detector"<br/>  },<br/>  {<br/>    "config": "",<br/>    "name": "csi-plugin"<br/>  },<br/>  {<br/>    "config": "",<br/>    "name": "csi-provisioner"<br/>  }<br/>]</pre> | no |
| <a name="input_cluster_spec"></a> [cluster\_spec](#input\_cluster\_spec) | The cluster specifications of kubernetes cluster,which can be empty. Valid values:ack.standard : Standard managed clusters; ack.pro.small : Professional managed clusters. | `string` | `"ack.pro.small"` | no |
| <a name="input_k8s_name_prefix"></a> [k8s\_name\_prefix](#input\_k8s\_name\_prefix) | The name prefix used to create managed kubernetes cluster. | `string` | `"tf-ack"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
| <a name="input_node_vswitch_cidrs"></a> [node\_vswitch\_cidrs](#input\_node\_vswitch\_cidrs) | 用于创建新vSwitches的CIDR地址块列表。 | `list(string)` | <pre>[<br/>  "172.16.0.0/23",<br/>  "172.16.2.0/23",<br/>  "172.16.4.0/23"<br/>]</pre> | no |
| <a name="input_nodepool_name"></a> [nodepool\_name](#input\_nodepool\_name) | n/a | `string` | `"default-nodepool"` | no |
| <a name="input_password"></a> [password](#input\_password) | The password of ECS instance. | `string` | `"Test123456"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_strategy"></a> [strategy](#input\_strategy) | The deployment strategy. Valid values: Availability, AvailabilityGroup, LowLatency. | `string` | `"Availability"` | no |
| <a name="input_terway_vswitch_cidrs"></a> [terway\_vswitch\_cidrs](#input\_terway\_vswitch\_cidrs) | 用于创建Terway使用的vSwitch的CIDR地址块。 | `list(string)` | <pre>[<br/>  "172.16.208.0/20",<br/>  "172.16.224.0/20",<br/>  "172.16.240.0/20"<br/>]</pre> | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | `"tf-vpc"` | no |
| <a name="input_worker_instance_types"></a> [worker\_instance\_types](#input\_worker\_instance\_types) | The ecs instance types used to launch worker nodes. | `list` | <pre>[<br/>  "ecs.g6.2xlarge",<br/>  "ecs.g6.xlarge"<br/>]</pre> | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Associate deployment set with ACK node pool](http://help.aliyun.com/document_detail/391261.htm) 

<!-- docs-link --> 