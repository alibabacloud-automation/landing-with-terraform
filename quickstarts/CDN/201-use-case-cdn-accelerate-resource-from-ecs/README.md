## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上使用CDN加速ECS上的静态资源。
详情可查看[CDN加速ECS资源](https://help.aliyun.com/zh/cdn/use-cases/use-alibaba-cloud-cdn-to-accelerate-the-retrieval-of-resources-from-an-ecs-instance)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use CDN to accelerate the retrieval of resources from an Elastic Compute Service (ECS) instance on Alibaba Cloud.
More details in [Use Alibaba Cloud CDN to accelerate the retrieval of resources from an ECS instance](https://help.aliyun.com/zh/cdn/use-cases/use-alibaba-cloud-cdn-to-accelerate-the-retrieval-of-resources-from-an-ecs-instance).
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
| [alicloud_alidns_record.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_record) | resource |
| [alicloud_cdn_domain_new.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cdn_domain_new) | resource |
| [alicloud_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.egress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_creater_ecs"></a> [creater\_ecs](#input\_creater\_ecs) | Do you want to create a ECS instance | `bool` | `true` | no |
| <a name="input_domain_home"></a> [domain\_home](#input\_domain\_home) | your domain name | `string` | `"tf-example.com"` | no |
| <a name="input_existed_ecs_ip"></a> [existed\_ecs\_ip](#input\_existed\_ecs\_ip) | The ip of your existed ecs | `string` | `""` | no |
| <a name="input_host_record"></a> [host\_record](#input\_host\_record) | Host Record,like image | `string` | `"image"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-beijing"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use Alibaba Cloud CDN to accelerate the retrieval of resources from an ECS instance](https://help.aliyun.com/zh/cdn/use-cases/use-alibaba-cloud-cdn-to-accelerate-the-retrieval-of-resources-from-an-ecs-instance) 

<!-- docs-link --> 