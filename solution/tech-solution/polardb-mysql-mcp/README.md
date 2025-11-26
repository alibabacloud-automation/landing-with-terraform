## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[MCP 赋能可视化 OLAP 智能体应用
](https://www.aliyun.com/solution/tech-solution/polardb-mysql-mcp)，涉及专有网络（VPC）、交换机（VSwitch）、PolarDB数据库（PolarDB）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [MCP empowers visual OLAP intelligent agent applications](https://www.aliyun.com/solution/tech-solution/polardb-mysql-mcp), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), PolarDB Database (PolarDB).
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
| [alicloud_polardb_account.account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_account) | resource |
| [alicloud_polardb_cluster.polardb_cluster](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_cluster) | resource |
| [alicloud_polardb_database.polardb_database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_database) | resource |
| [alicloud_polardb_endpoint_address.dbcluster_endpoint_address](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_endpoint_address) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_polardb_endpoints.polardb_endpoints](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/polardb_endpoints) | data source |
| [alicloud_polardb_node_classes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/polardb_node_classes) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | account\_name | `string` | `"polar_ai"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | db\_password | `string` | n/a | yes |
| <a name="input_dbname"></a> [dbname](#input\_dbname) | dbname | `string` | `"db-test"` | no |
<!-- END_TF_DOCS -->