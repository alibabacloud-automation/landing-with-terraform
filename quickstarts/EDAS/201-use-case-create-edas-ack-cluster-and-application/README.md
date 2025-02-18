## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建Kubernetes集群并添加节点，随后将该Kubernetes集群导入EDAS，最终实现应用在Kubernetes集群中的部署。
详情可查看[通过Terraform创建K8s集群并部署应用](http://help.aliyun.com/document_detail/204699.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create Container Service for Kubernetes (ACK) clusters in ACK, import the ACK clusters to Enterprise Distributed Application Service (EDAS), and then deploy applications in the ACK clusters. 
More details in [Use Terraform to create an ACK cluster and deploy an application](http://help.aliyun.com/document_detail/204699.htm).
<!-- DOCS_DESCRIPTION_EN -->

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
| [alicloud_cs_kubernetes_node_pool.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_managed_kubernetes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_managed_kubernetes) | resource |
| [alicloud_edas_k8s_application.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_k8s_application) | resource |
| [alicloud_edas_k8s_cluster.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_k8s_cluster) | resource |
| [alicloud_edas_namespace.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_namespace) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_spec"></a> [cluster\_spec](#input\_cluster\_spec) | n/a | `string` | `"ack.pro.small"` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | n/a | `string` | `"ecs.g5ne.xlarge"` | no |
| <a name="input_jdk"></a> [jdk](#input\_jdk) | n/a | `string` | `"Open JDK 8"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | n/a | `string` | `"1.31.1-aliyun.1"` | no |
| <a name="input_package_url"></a> [package\_url](#input\_package\_url) | n/a | `string` | `"http://edas-bj.oss-cn-beijing.aliyuncs.com/prod/demo/SPRING_CLOUD_PROVIDER.jar"` | no |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | n/a | `string` | `"192.168.0.0/16"` | no |
| <a name="input_proxy_mode"></a> [proxy\_mode](#input\_proxy\_mode) | Proxy mode is option of kube-proxy. | `string` | `"ipvs"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | n/a | `string` | `"172.21.0.0/20"` | no |
| <a name="input_system_disk_category"></a> [system\_disk\_category](#input\_system\_disk\_category) | n/a | `string` | `"cloud_efficiency"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | n/a | `string` | `"172.16.0.0/22"` | no |
| <a name="input_vsw_cidr_block"></a> [vsw\_cidr\_block](#input\_vsw\_cidr\_block) | n/a | `string` | `"172.16.0.0/24"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create EDAS ACK cluster and appliaction](http://help.aliyun.com/document_detail/204699.htm) 

<!-- docs-link --> 