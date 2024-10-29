## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云ECS实例上搭建一个 Flask Web 应用，涉及到专有网络VPC、虚拟交换机vSwitch、安全组、弹性计算实例等资源的创建和部署。
详情可查看[Terraform 使用入门](https://help.aliyun.com/document_detail/2847220.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to build a Flask web application on an Alibaba Cloud ECS instance, which involves the creation and deployment of resources such as Virtual Private Cloud, virtual Switches, security groups, and Elastic Compute Service instances.
More details in [Getting Started with Terraform](https://help.aliyun.com/document_detail/2847220.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_tcp_22](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_5000](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [null_resource.deploy](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | n/a | `string` | `"ubuntu_18_04_64_20G_alibase_20190624.vhd"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"deploying-flask-web-server"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ecs.n1.tiny"` | no |
| <a name="input_internet_bandwidth"></a> [internet\_bandwidth](#input\_internet\_bandwidth) | n/a | `number` | `10` | no |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | `"Test@12345"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_web_content"></a> [web\_content](#input\_web\_content) | n/a | `string` | `"你好，阿里云！"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link -->

The template is based on Aliyun document: [Getting Started with Terraform](https://help.aliyun.com/document_detail/2847220.html)

<!-- docs-link -->
