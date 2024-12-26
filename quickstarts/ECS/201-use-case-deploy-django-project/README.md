## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上的Linux服务器中使用Nginx+uWSGI部署Django项目。
详情可查看[使用Nginx+uWSGI部署Django项目](https://help.aliyun.com/zh/ecs/use-cases/use-nginx-and-uwsgi-to-deploy-a-django-project)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use NGINX and uWSGI to deploy a Django project on a Linux Elastic Compute Service (ECS) instance.
More details in [Use NGINX and uWSGI to deploy a Django project](https://help.aliyun.com/zh/ecs/use-cases/use-nginx-and-uwsgi-to-deploy-a-django-project).
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
| [alicloud_ecs_command.deploy_django](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.django_ecs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.django_sg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_icmp_all](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_22](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_80](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.django_vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.django_vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_instances.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instances) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | Common name for resources. | `string` | `"deploy_django_by_tf"` | no |
| <a name="input_ecs_instance_id"></a> [ecs\_instance\_id](#input\_ecs\_instance\_id) | ECS instance ID if using an existing instance. Note: This one-click deployment script only supports Alibaba Cloud Linux 3, please do not select instances of other operating systems. | `string` | `""` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | Image of instance. | `string` | `"aliyun_3_x64_20G_alibase_20240528.vhd"` | no |
| <a name="input_instance_password"></a> [instance\_password](#input\_instance\_password) | Server login password, length 8-30, must contain three (Capital letters, lowercase letters, numbers, `~!@#$%^&*_-+=|{}[]:;'<>?,./ Special symbol in)` | `string` | `"Test@123456"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type. | `string` | `"ecs.e-c1m2.large"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-chengdu"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use NGINX and uWSGI to deploy a Django project](https://help.aliyun.com/zh/ecs/use-cases/use-nginx-and-uwsgi-to-deploy-a-django-project) 

<!-- docs-link --> 