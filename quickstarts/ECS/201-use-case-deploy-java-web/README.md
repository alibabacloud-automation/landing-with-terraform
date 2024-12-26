## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云ECS实例中部署Java Web环境。
详情可查看[手动部署Java Web环境（Tomcat）](https://help.aliyun.com/zh/ecs/use-cases/manually-deploy-a-java-web-environment-on-an-instance-that-runs-alibaba-cloud-linux)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to deploy a Java web environment on an Elastic Compute Service (ECS) instance.
More details in [Deploy a Java web environment (Apache Tomcat)](https://help.aliyun.com/zh/ecs/use-cases/manually-deploy-a-java-web-environment-on-an-instance-that-runs-alibaba-cloud-linux).
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
| [alicloud_ecs_command.deploy_java_web](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.sg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_icmp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_ssh](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_web](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_instances.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instances) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | Common name for resources | `string` | `"deploy-java-web-by-terraform"` | no |
| <a name="input_ecs_instance_id"></a> [ecs\_instance\_id](#input\_ecs\_instance\_id) | ECS instance ID if using an existing instance | `string` | `""` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | Image ID for the instance | `string` | `"aliyun_3_x64_20G_alibase_20240528.vhd"` | no |
| <a name="input_instance_password"></a> [instance\_password](#input\_instance\_password) | Server login password | `string` | `"Test@123456"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | `"ecs.e-c1m2.large"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where resources will be created | `string` | `"cn-chengdu"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Deploy Java Web environment](https://help.aliyun.com/zh/ecs/use-cases/manually-deploy-a-java-web-environment-on-an-instance-that-runs-alibaba-cloud-linux) 

<!-- docs-link --> 
