## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[原生 SQL 轻松实现多模态智能检索](https://www.aliyun.com/solution/tech-solution/polardb-ai-search)，涉及专有网络（VPC）、交换机（VSwitch）、PolarDB数据库（PolarDB）、对象存储服务（OSS）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Native SQL enables effortless multimodal intelligent search](https://www.aliyun.com/solution/tech-solution/polardb-ai-search), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), PolarDB Database (PolarDB), Object Storage Service (OSS).
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
| [alicloud_oss_bucket.ossbucket](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_polardb_account.account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_account) | resource |
| [alicloud_polardb_cluster.polardb_cluster](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_cluster) | resource |
| [alicloud_polardb_database.polardb_database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_database) | resource |
| [alicloud_polardb_endpoint_address.dbcluster_endpoint_address](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_endpoint_address) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_string.lowercase](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [alicloud_oss_service.open_oss](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/oss_service) | data source |
| [alicloud_polardb_endpoints.polardb_endpoints](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/polardb_endpoints) | data source |
| [alicloud_polardb_node_classes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/polardb_node_classes) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | account\_name | `string` | `"polar_ai"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | bucket\_name,在同一可用区下请保持唯一 | `string` | `"test-bucket-polar"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | account\_password | `string` | n/a | yes |
| <a name="input_dbname"></a> [dbname](#input\_dbname) | dbname | `string` | `"db-test"` | no |
<!-- END_TF_DOCS -->