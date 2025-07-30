## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[部署 Nginx 并通过 Ingress 暴露服务](https://www.aliyun.com/solution/tech-solution/nginx-ingress), 涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、 容器服务 Kubernetes（ACK）、日志服务（SLS）。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example demonstrates the implementation of the solution [Deploy Nginx and expose the service through Ingress](https://www.aliyun.com/solution/tech-solution/nginx-ingress). It involves the creation, configuration, and deployment of resources such as Virtual Private Cloud (Vpc), Virtual Switch (VSwitch), Elastic Compute Service (Ecs), Container Service for Kubernetes (ACK), and Simple Log Service (SLS).
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
| [alicloud_cs_kubernetes_node_pool.node_pool](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_managed_kubernetes.ack](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_managed_kubernetes) | resource |
| [alicloud_ram_role.role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_ack_service.open_ack](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ack_service) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_log_service.open_sls](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/log_service) | data source |
| [alicloud_ram_roles.roles](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_roles) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ack_name"></a> [ack\_name](#input\_ack\_name) | 集群名称：The name must be 1 to 63 characters in length and can contain letters, Chinese characters, digits, and hyphens (-). | `string` | `"cluster-for-nginx-test"` | no |
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | Common Name | `string` | `"ack-for-nginx"` | no |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->