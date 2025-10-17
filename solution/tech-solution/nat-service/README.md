## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[高效安全：企业统一公网出口](https://www.aliyun.com/solution/tech-solution/nat-service), 涉及到专有网络VPC、虚拟交换机vSwitch、公网 NAT 网关、云服务器ECS等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Efficient and Secure: Unified Public Network Egress](https://www.aliyun.com/solution/tech-solution/nat-service), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (vSwitch), Internet NAT Gateway and Elastic Compute Service (ECS).
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
| [alicloud_instance.ecs_instance1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.ecs_instance2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_nat_gateway.nat_gateway](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nat_gateway) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_https](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_workbench](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_snat_entry.snat](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/snat_entry) | resource |
| [alicloud_snat_entry.snat2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/snat_entry) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_password"></a> [instance\_password](#input\_instance\_password) | 服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_instance_type1"></a> [instance\_type1](#input\_instance\_type1) | ECS1 实例规格 | `string` | `"ecs.e-c1m2.large"` | no |
| <a name="input_instance_type2"></a> [instance\_type2](#input\_instance\_type2) | ECS2 实例规格 | `string` | `"ecs.e-c1m2.large"` | no |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
| <a name="input_region_zone_id1"></a> [region\_zone\_id1](#input\_region\_zone\_id1) | 可用区1 | `string` | `"cn-hangzhou-j"` | no |
| <a name="input_region_zone_id2"></a> [region\_zone\_id2](#input\_region\_zone\_id2) | 可用区2 | `string` | `"cn-hangzhou-k"` | no |
<!-- END_TF_DOCS -->