## Introduction

This example is used to create a `alicloud_polardb_zonal_db_cluster` resource.

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
| [alicloud_ens_network.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ens_network) | resource |
| [alicloud_ens_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ens_vswitch) | resource |
| [alicloud_polardb_zonal_db_cluster.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_zonal_db_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_cluster_nodes_configs"></a> [db\_cluster\_nodes\_configs](#input\_db\_cluster\_nodes\_configs) | The advanced configuration for all nodes in the cluster except for the RW node, including db\_node\_class, hot\_replica\_mode, and imci\_switch properties. | <pre>map(object({<br/>    db_node_class    = string<br/>    db_node_role     = optional(string, null)<br/>    hot_replica_mode = optional(string, null)<br/>    imci_switch      = optional(string, null)<br/>  }))</pre> | <pre>{<br/>  "db_node_1": {<br/>    "db_node_class": "polar.mysql.x4.medium.c",<br/>    "db_node_role": "Writer"<br/>  },<br/>  "db_node_2": {<br/>    "db_node_class": "polar.mysql.x4.medium.c",<br/>    "db_node_role": "Reader"<br/>  }<br/>}</pre> | no |
<!-- END_TF_DOCS -->
