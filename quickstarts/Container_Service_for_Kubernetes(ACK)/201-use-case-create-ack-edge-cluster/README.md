## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建ACK Edge集群。
详情可查看[使用Terraform创建ACK Edge集群](http://help.aliyun.com/document_detail/2392138.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create ACK Edge cluster on Alibaba Cloud.
More details in [Use Terraform to create an ACK Edge cluster](http://help.aliyun.com/document_detail/2392138.htm).
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
| [alicloud_cs_edge_kubernetes.edge](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_edge_kubernetes) | resource |
| [alicloud_cs_kubernetes_node_pool.nodepool](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_spec"></a> [cluster\_spec](#input\_cluster\_spec) | The cluster specifications of kubernetes cluster,which can be empty. Valid values:ack.standard : Standard managed clusters; ack.pro.small : Professional managed clusters. | `string` | `"ack.pro.small"` | no |
| <a name="input_containerd_runtime_version"></a> [containerd\_runtime\_version](#input\_containerd\_runtime\_version) | n/a | `string` | `"1.6.34"` | no |
| <a name="input_k8s_login_password"></a> [k8s\_login\_password](#input\_k8s\_login\_password) | n/a | `string` | `"Test123456"` | no |
| <a name="input_k8s_name_edge"></a> [k8s\_name\_edge](#input\_k8s\_name\_edge) | The name used to create edge kubernetes cluster. | `string` | `"edge-example"` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Kubernetes version | `string` | `"1.28.9-aliyun.1"` | no |
| <a name="input_new_vpc_name"></a> [new\_vpc\_name](#input\_new\_vpc\_name) | The name used to create vpc. | `string` | `"tf-vpc-172-16"` | no |
| <a name="input_new_vsw_name"></a> [new\_vsw\_name](#input\_new\_vsw\_name) | The name used to create vSwitch. | `string` | `"tf-vswitch-172-16-0"` | no |
| <a name="input_nodepool_name"></a> [nodepool\_name](#input\_nodepool\_name) | The name used to create node pool. | `string` | `"edge-nodepool-1"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create ACK edge cluster](http://help.aliyun.com/document_detail/2392138.htm) 

<!-- docs-link --> 