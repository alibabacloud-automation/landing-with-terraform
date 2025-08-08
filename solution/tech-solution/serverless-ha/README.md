## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[极简运维，Serverless 高可用架构](https://www.aliyun.com/solution/tech-solution/serverless-ha), 涉及到专有网络（VPC）、交换机（VSwitch）、云原生数据库PolarDB MySQL版、应用型负载均衡（ALB）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Minimal Operations, Serverless High Availability Architecture](https://www.aliyun.com/solution/tech-solution/serverless-ha), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, PolarDB for MySQL, Application Load Balancer (ALB).
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
| [alicloud_alb_load_balancer.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_load_balancer) | resource |
| [alicloud_polardb_account.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_account) | resource |
| [alicloud_polardb_account_privilege.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_account_privilege) | resource |
| [alicloud_polardb_cluster.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_cluster) | resource |
| [alicloud_polardb_database.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_database) | resource |
| [alicloud_sae_application.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/sae_application) | resource |
| [alicloud_sae_ingress.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/sae_ingress) | resource |
| [alicloud_sae_namespace.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/sae_namespace) | resource |
| [alicloud_security_group.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_https](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_mysql](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.db_01](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.pub_01](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.pub_02](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.web_01](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.web_02](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait_app](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | 通用名称前缀 | `string` | `"serverless"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | MySQL数据库密码，长度8-30，必须包含三项（大写字母、小写字母、数字、特殊符号） | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | MySQL数据库账号 | `string` | `"applets"` | no |
| <a name="input_region"></a> [region](#input\_region) | 阿里云地域 | `string` | `"cn-hangzhou"` | no |
| <a name="input_zone_id_1"></a> [zone\_id\_1](#input\_zone\_id\_1) | 可用区1 | `string` | n/a | yes |
| <a name="input_zone_id_2"></a> [zone\_id\_2](#input\_zone\_id\_2) | 可用区2 | `string` | n/a | yes |
<!-- END_TF_DOCS -->