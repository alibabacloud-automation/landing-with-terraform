## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[PAI 部署多形态的 Stable Diffusion WebUI 服务](https://www.aliyun.com/solution/tech-solution/pai-eas), 涉及到 PAI、NAS、NAT网关 等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [PAI 部署多形态的 Stable Diffusion WebUI 服务](https://www.aliyun.com/solution/tech-solution/pai-eas), which involves the creation and deployment of resources such as PAI、NAS、NAT gateway.
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
| [alicloud_eip.eip](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip) | resource |
| [alicloud_eip_association.eip_association](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_association) | resource |
| [alicloud_nas_access_group.nas_access_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_access_group) | resource |
| [alicloud_nas_access_rule.nas_access_rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_access_rule) | resource |
| [alicloud_nas_file_system.nas](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_file_system) | resource |
| [alicloud_nas_mount_target.nas_mount_target](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_mount_target) | resource |
| [alicloud_nat_gateway.nat_gateway](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nat_gateway) | resource |
| [alicloud_pai_service.pai_eas](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/pai_service) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_https](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_snat_entry.snat_entry](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/snat_entry) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_string.random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | PAI-EAS实例规格 | `string` | `"ecs.gn6i-c16g1.4xlarge"` | no |
| <a name="input_region"></a> [region](#input\_region) | 地域，由于在新加坡地域开通弹性公网 IP 服务后，访问 Civitai 和Github 的网速高效稳定，此处选择新加坡 | `string` | `"ap-southeast-1"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | 可用区ID | `string` | `"ap-southeast-1c"` | no |
<!-- END_TF_DOCS -->