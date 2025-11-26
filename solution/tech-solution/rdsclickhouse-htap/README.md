## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[RDS 与 ClickHouse 构建一站式 HTAP
](https://www.aliyun.com/solution/tech-solution/rdsclickhouse-htap)，涉及专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、RDS数据库（RDS）、ClickHouse数据库（ClickHouse）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [RDS and ClickHouse enable an all-in-one HTAP solution](https://www.aliyun.com/solution/tech-solution/rdsclickhouse-htap), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), Elastic Compute Service (ECS), RDS Database (RDS), ClickHouse Database (ClickHouse).
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
| [alicloud_click_house_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/click_house_account) | resource |
| [alicloud_click_house_db_cluster.click_house](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/click_house_db_cluster) | resource |
| [alicloud_db_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_account) | resource |
| [alicloud_db_database.database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.rds_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_ecs_command.run_tpcc_alicloud_ecs_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.run_tpcc_alicloud_ecs_invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_db_zones.zones_ids](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |
| [alicloud_images.centos_7_9](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_click_house_user"></a> [click\_house\_user](#input\_click\_house\_user) | ClickHouse数据库账号 | `string` | `"ck_user"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | 数据库实例规格，请在以下规格中选择【8C32G, 16C64G, 32C128G,64C256G】 | `string` | `"8C32G"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | 数据库密码 | `string` | n/a | yes |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | ecs实例密码 | `string` | n/a | yes |
| <a name="input_ecs_instance_type"></a> [ecs\_instance\_type](#input\_ecs\_instance\_type) | 实例类型 | `string` | `"ecs.e-c1m2.large"` | no |
| <a name="input_rds_db_user"></a> [rds\_db\_user](#input\_rds\_db\_user) | RDS数据库账号 | `string` | `"rds_user"` | no |
<!-- END_TF_DOCS -->