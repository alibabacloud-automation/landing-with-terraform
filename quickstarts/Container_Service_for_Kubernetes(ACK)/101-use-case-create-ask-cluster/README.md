## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建ACK Serverless集群。
详情可查看[创建ACK Serverless集群](http://help.aliyun.com/document_detail/2391966.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create ACK Serverless cluster on Alibaba Cloud.
More details in [Create an ACK Serverless cluster](http://help.aliyun.com/document_detail/2391966.htm).
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
| [alicloud_cs_serverless_kubernetes.serverless](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_serverless_kubernetes) | resource |
| [alicloud_security_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_eci_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/eci_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ack_version"></a> [ack\_version](#input\_ack\_version) | Desired Kubernetes version. | `string` | `"1.31.1-aliyun.1"` | no |
| <a name="input_cluster_spec"></a> [cluster\_spec](#input\_cluster\_spec) | The cluster specifications of kubernetes cluster,which can be empty. Valid values:ack.standard : Standard managed clusters; ack.pro.small : Professional managed clusters. | `string` | `"ack.pro.small"` | no |
| <a name="input_k8s_name_prefix"></a> [k8s\_name\_prefix](#input\_k8s\_name\_prefix) | The name prefix used to create ASK cluster. | `string` | `"ask-example"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-shenzhen"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create ASK cluster](http://help.aliyun.com/document_detail/2391966.htm) 

<!-- docs-link --> 