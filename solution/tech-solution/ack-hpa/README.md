## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[容器化应用的弹性伸缩攻略](https://www.aliyun.com/solution/tech-solution/ack-hpa), 涉及到专有网络（VPC）、虚拟交换机（VSwitch）、专有网络 NAT 网关（NAT Gateway）、容器服务 Kubernetes 版（ACK）、应用型负载均衡（ALB）、云服务器（ECS）、日志服务（SLS）等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example demonstrates the implementation of the solution [Guide to Elastic Scaling for Containerized Applications](https://www.aliyun.com/solution/tech-solution/ack-hpa). It involves the creation, configuration, and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), NAT Gateway, Container Service for Kubernetes (ACK), Application Load Balancer (ALB), Elastic Compute Service (ECS), and Log Service (SLS).
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
| [alicloud_cs_kubernetes_node_pool.node_pool](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_managed_kubernetes.ack](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_managed_kubernetes) | resource |
| [alicloud_log_project.sls_project](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_ram_role.role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ros_stack.deploy_k8s_resource](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ros_stack) | resource |
| [alicloud_security_group.sg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.ingress_http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.ingress_https](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [time_sleep.wait_node_ready](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [alicloud_ack_service.open_ack](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ack_service) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_log_service.open_sls](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/log_service) | data source |
| [alicloud_ram_roles.roles](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_roles) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | 集群名称 | `string` | `"k8s-hpa-cluster"` | no |
| <a name="input_managed_kubernetes_cluster_name"></a> [managed\_kubernetes\_cluster\_name](#input\_managed\_kubernetes\_cluster\_name) | ACK托管版集群名称 | `string` | `"k8s-hpa-cluster"` | no |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
| <a name="input_sls_project_name"></a> [sls\_project\_name](#input\_sls\_project\_name) | 日志项目的名称，长度为3~36个字符。必须以小写英文字母或数字开头和结尾。可包含小写英文字母、数字和短划线（-） | `string` | `"k8s-hpa-sls-project-example"` | no |
<!-- END_TF_DOCS -->