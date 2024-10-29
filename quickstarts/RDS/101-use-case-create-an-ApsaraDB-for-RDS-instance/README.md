
## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个云数据库实例，涉及到专有网络VPC、虚拟交换机vSwitch、RDS数据库实例及相关数据库和账号等资源的创建和部署。
详情可查看[创建一个云数据库实例](https://help.aliyun.com/document_detail/111635.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create an ApsaraDB for RDS instance on Alibaba Cloud, which involves the creation and deployment of resources such as Virtual Private Cloud, virtual Switches, ApsaraDB for RDS instances, and related databases and accounts.
More details in [Create an ApsaraDB for RDS instance](https://help.aliyun.com/document_detail/111635.html).
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
| [alicloud_db_account_privilege.privilege](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_account_privilege) | resource |
| [alicloud_db_connection.connection](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_connection) | resource |
| [alicloud_db_database.db](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_rds_account.account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

No inputs.
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link -->

The template is based on Aliyun document: [Create an ApsaraDB for RDS instance](https://help.aliyun.com/document_detail/111635.html)

<!-- docs-link -->
