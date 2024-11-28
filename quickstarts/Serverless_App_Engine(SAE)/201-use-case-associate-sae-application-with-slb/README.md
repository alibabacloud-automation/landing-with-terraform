## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上为SAE应用绑定和解绑公网SLB，涉及到SAE应用与SLB的配置。
详情可查看[使用Terraform为SAE应用绑定SLB](http://help.aliyun.com/document_detail/424337.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to associate an Internet-facing SLB instance with an SAE application and how to disassociate the SLB instance on Alibaba Cloud, which involves the configuration of SAE application and SLB.
More details in [Use Terraform to associate an SAE application with an SLB instance](http://help.aliyun.com/document_detail/424337.htm).
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
| [alicloud_sae_application.manual](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/sae_application) | resource |
| [alicloud_sae_load_balancer_internet.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/sae_load_balancer_internet) | resource |
| [alicloud_sae_namespace.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/sae_namespace) | resource |
| [alicloud_security_group.sg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.sg_rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_slb_load_balancer.slb](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_description"></a> [app\_description](#input\_app\_description) | The description of the application | `string` | `"description created by Terraform"` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | 应用名称 | `string` | `"app-slb"` | no |
| <a name="input_cidr_ip"></a> [cidr\_ip](#input\_cidr\_ip) | cidr blocks used to create a new security group rule | `string` | `"0.0.0.0/0"` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The cpu of the application, in unit of millicore | `string` | `"500"` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the security group rule | `string` | `"The description of the security group rule"` | no |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | 镜像地址 | `string` | `"registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-slim:0.9"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The memory of the application, in unit of MB | `string` | `"1024"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the security group rule | `string` | `"tf"` | no |
| <a name="input_namespace_description"></a> [namespace\_description](#input\_namespace\_description) | Namespace Description | `string` | `"a namespace"` | no |
| <a name="input_namespace_id"></a> [namespace\_id](#input\_namespace\_id) | 命名空间ID | `string` | `"cn-shenzhen:demo"` | no |
| <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name) | 命名空间名称 | `string` | `"demo"` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | The package type of the application | `string` | `"Image"` | no |
| <a name="input_port"></a> [port](#input\_port) | The port of SLB | `string` | `"8000"` | no |
| <a name="input_port_range"></a> [port\_range](#input\_port\_range) | The port range of the security group rule | `string` | `"1/65535"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | 变量定义 | `string` | `"cn-shenzhen"` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | The replicas of the application | `string` | `"1"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Availability Zone ID | `string` | `"cn-shenzhen-a"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use Terraform to associate an SAE application with an SLB instance](http://help.aliyun.com/document_detail/424337.htm) 

<!-- docs-link --> 