## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上操作云工作流定时调度。
详情可查看[使用Terraform操作云工作流定时调度](https://help.aliyun.com/document_detail/2849938.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to configure FNF time-based workflow scheduling on Alibaba Cloud. 
More details in [Use Terraform to configure FNF time-based workflow scheduling](https://help.aliyun.com/document_detail/2849938.html).
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
| [alicloud_event_bridge_event_bus.eventbus_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_event_bus) | resource |
| [alicloud_event_bridge_event_source.eventsource_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_event_source) | resource |
| [alicloud_event_bridge_rule.eventrule_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_rule) | resource |
| [alicloud_fnf_flow.flow_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fnf_flow) | resource |
| [alicloud_mns_queue.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mns_queue) | resource |
| [alicloud_ram_policy.policy_exmaple](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_role.role_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.attach_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_account.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_event_bus_description"></a> [event\_bus\_description](#input\_event\_bus\_description) | 定义变量总线描述。 | `string` | `"For event_bus_description"` | no |
| <a name="input_event_bus_name"></a> [event\_bus\_name](#input\_event\_bus\_name) | The name of the event bus. | `string` | `"test-eventbus1"` | no |
| <a name="input_event_rule_name"></a> [event\_rule\_name](#input\_event\_rule\_name) | The name of the event rule. | `string` | `"test-eventrule1"` | no |
| <a name="input_event_source_name"></a> [event\_source\_name](#input\_event\_source\_name) | The name of the event source. | `string` | `"test-eventsource1"` | no |
| <a name="input_flow_description"></a> [flow\_description](#input\_flow\_description) | 定义流的描述 | `string` | `"For flow_description"` | no |
| <a name="input_flow_name"></a> [flow\_name](#input\_flow\_name) | The name of the flow. | `string` | `"test-flow"` | no |
| <a name="input_name"></a> [name](#input\_name) | 变量定义名称。 | `string` | `"test-mns"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the policy. | `string` | `"test-policy"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The role for eb to start execution of flow. | `string` | `"eb-to-fnf-role"` | no |
| <a name="input_target_id"></a> [target\_id](#input\_target\_id) | The ID of the target. | `string` | `"test-target1"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use Terraform to configure FNF time-based workflow scheduling](https://help.aliyun.com/document_detail/2849938.html) 

<!-- docs-link --> 