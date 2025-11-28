## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[SelectDB实现日志高效存储与实时分析](https://www.aliyun.com/solution/tech-solution/real-time-log-analysis-with-selectdb)，涉及专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、SelectDB数据库（SelectDB）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [SelectDB enables efficient log storage and real-time analytics](https://www.aliyun.com/solution/tech-solution/real-time-log-analysis-with-selectdb), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), Elastic Compute Service (ECS), SelectDB Database (SelectDB).
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
| [alicloud_ecs_command.run_tpcc_alicloud_ecs_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.run_tpcc_alicloud_ecs_invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.sg_select](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_selectdb_db_instance.selectdb_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/selectdb_db_instance) | resource |
| [alicloud_vpc.vpc_select](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw_select](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_images.image_id](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | SelectDB admin账号密码 | `string` | n/a | yes |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | ECS服务器root账号密码 | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | SelectDB实例规格 | `string` | `"selectdb.4xlarge"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | ECS实例类型，建议选择配备 16 vCPU 64 GiB 配置的实例 | `string` | `"ecs.g8i.4xlarge"` | no |
| <a name="input_selectdb_engine_version"></a> [selectdb\_engine\_version](#input\_selectdb\_engine\_version) | SelectDB内核版本 | `string` | `"4.0.4"` | no |
<!-- END_TF_DOCS -->