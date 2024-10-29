## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上部署一个托管版的Kubernetes集群。涉及到专有网络VPC、虚拟交换机vSwitch、托管版集群以及节点池等资源的创建。
详情可查看[使用Terraform创建托管版Kubernetes](https://help.aliyun.com/document_detail/146138.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a managed Kubernetes cluster on Alibaba Cloud, which involves the creation and deployment of resources such as Virtual Private Cloud, virtual Switches, ACK managed clusters, and node pools.
More details in [Create a managed Kubernetes cluster](https://help.aliyun.com/document_detail/146138.html).
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
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_log_project_name"></a> [log\_project\_name](#input\_log\_project\_name) | 日志服务项目名称 | `string` | `"my-first-kubernetes-sls-demo"` | no |
| <a name="input_name"></a> [name](#input\_name) | 默认资源名称 | `string` | `"my-first-kubernetes-demo"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-zhangjiakou"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link -->

The template creates a bucket basing on Aliyun document: [Create a managed Kubernetes cluster](https://help.aliyun.com/document_detail/146138.html)

<!-- docs-link -->
