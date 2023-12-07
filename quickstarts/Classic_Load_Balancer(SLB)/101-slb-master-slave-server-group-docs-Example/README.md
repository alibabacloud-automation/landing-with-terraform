<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_slb_master_slave_server_group` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_ecs_network_interface.ms_server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_network_interface) | resource |
| [alicloud_ecs_network_interface_attachment.ms_server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_network_interface_attachment) | resource |
| [alicloud_instance.ms_server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_slb_listener.tcp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_load_balancer.ms_server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_slb_master_slave_server_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_master_slave_server_group) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_images.image](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.ms_server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_zones.ms_server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_slb_master_slave_server_group"></a> [slb\_master\_slave\_server\_group](#input\_slb\_master\_slave\_server\_group) | n/a | `string` | `"forSlbMasterSlaveServerGroup"` | no |
<!-- END_TF_DOCS -->    