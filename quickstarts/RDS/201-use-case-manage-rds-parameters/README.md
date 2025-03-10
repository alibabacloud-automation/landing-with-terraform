## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上修改RDS参数以及查询参数修改日志，涉及到RDS PostgreSQL实例的创建，参数的修改和参数修改日志的查询。
详情可查看[通过 Terraform 管理 RDS PostgreSQL 实例参数](https://help.aliyun.com/document_detail/456036.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to modify parameters and query parameter modification logs of an ApsaraDB RDS for PostgreSQL instance on Alibaba Cloud, which involves the creation of ApsaraDB RDS for PostgreSQL instance, the modification of parameters and query for modification logs.
More details in [Manage RDS parameters](https://help.aliyun.com/document_detail/456036.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_db_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [time_static.example](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [alicloud_rds_modify_parameter_logs.querylogs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/rds_modify_parameter_logs) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"pg.n2.2c.2m"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-heyuan-a"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage RDS parameters](https://help.aliyun.com/document_detail/456036.html) 

<!-- docs-link --> 