## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建ECS集群、部署应用、绑定SLB、创建应用分组及扩容等操作，涉及到ECS集群，EDAS ECS应用，应用分组，负载均衡实例等资源的创建。
详情可查看[通过Terraform创建ECS集群并部署应用](https://help.aliyun.com/document_detail/171493.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create Elastic Compute Service (ECS) clusters and deploy applications in Enterprise Distributed Application Service (EDAS), bind Server Load Balancer (SLB) to the applications, create application groups, and scale out the applications on Alibaba Cloud.
More details in [Use Terraform to create an ECS cluster and deploy an application](https://help.aliyun.com/document_detail/171493.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_edas_application.app](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_application) | resource |
| [alicloud_edas_application_deployment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_application_deployment) | resource |
| [alicloud_edas_application_scale.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_application_scale) | resource |
| [alicloud_edas_cluster.cluster](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_cluster) | resource |
| [alicloud_edas_deploy_group.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_deploy_group) | resource |
| [alicloud_edas_instance_cluster_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_instance_cluster_attachment) | resource |
| [alicloud_edas_slb_attachment.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_slb_attachment) | resource |
| [alicloud_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_slb_load_balancer.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [time_sleep.example](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.example2](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ecs.e-c1m1.large"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | n/a | `string` | `"172.16.0.0/16"` | no |
| <a name="input_vsw_cidr_block"></a> [vsw\_cidr\_block](#input\_vsw\_cidr\_block) | n/a | `string` | `"172.16.0.0/24"` | no |
| <a name="input_war_url"></a> [war\_url](#input\_war\_url) | 官网demo地址 | `string` | `"http://edas-sz.oss-cn-shenzhen.aliyuncs.com/prod/demo/SPRING_CLOUD_CONSUMER.jar"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create EDAS ECS clusters and application](https://help.aliyun.com/document_detail/171493.html) 

<!-- docs-link --> 