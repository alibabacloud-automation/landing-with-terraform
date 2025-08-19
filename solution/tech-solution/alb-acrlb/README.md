## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[ALB 实现跨地域负载均衡](https://www.aliyun.com/solution/tech-solution/alb-acrlb), 涉及到涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、云企业网(CEN)、应用型负载均衡（ALB）等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example demonstrates the implementation of the solution [Implementing Cross-Region Load Balancing with ALB](https://www.aliyun.com/solution/tech-solution/alb-acrlb). It involves the creation, configuration, and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), Cloud Enterprise Network (CEN), Application Load Balancer (ALB).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_chengdu_back_to_source_routing_cidr1"></a> [alb\_chengdu\_back\_to\_source\_routing\_cidr1](#input\_alb\_chengdu\_back\_to\_source\_routing\_cidr1) | n/a | `string` | `"100.117.130.0/25"` | no |
| <a name="input_alb_chengdu_back_to_source_routing_cidr2"></a> [alb\_chengdu\_back\_to\_source\_routing\_cidr2](#input\_alb\_chengdu\_back\_to\_source\_routing\_cidr2) | n/a | `string` | `"100.117.130.128/25"` | no |
| <a name="input_alb_chengdu_back_to_source_routing_cidr3"></a> [alb\_chengdu\_back\_to\_source\_routing\_cidr3](#input\_alb\_chengdu\_back\_to\_source\_routing\_cidr3) | n/a | `string` | `"100.117.131.0/25"` | no |
| <a name="input_alb_chengdu_back_to_source_routing_cidr4"></a> [alb\_chengdu\_back\_to\_source\_routing\_cidr4](#input\_alb\_chengdu\_back\_to\_source\_routing\_cidr4) | n/a | `string` | `"100.117.131.128/25"` | no |
| <a name="input_alb_chengdu_back_to_source_routing_cidr5"></a> [alb\_chengdu\_back\_to\_source\_routing\_cidr5](#input\_alb\_chengdu\_back\_to\_source\_routing\_cidr5) | n/a | `string` | `"100.122.175.64/26"` | no |
| <a name="input_alb_chengdu_back_to_source_routing_cidr6"></a> [alb\_chengdu\_back\_to\_source\_routing\_cidr6](#input\_alb\_chengdu\_back\_to\_source\_routing\_cidr6) | n/a | `string` | `"100.122.175.128/26"` | no |
| <a name="input_alb_chengdu_back_to_source_routing_cidr7"></a> [alb\_chengdu\_back\_to\_source\_routing\_cidr7](#input\_alb\_chengdu\_back\_to\_source\_routing\_cidr7) | n/a | `string` | `"100.122.175.192/26"` | no |
| <a name="input_alb_chengdu_back_to_source_routing_cidr8"></a> [alb\_chengdu\_back\_to\_source\_routing\_cidr8](#input\_alb\_chengdu\_back\_to\_source\_routing\_cidr8) | n/a | `string` | `"100.122.176.0/26"` | no |
| <a name="input_ecs_password"></a> [ecs\_password](#input\_ecs\_password) | Password for ECS instances | `string` | `"Test12345!"` | no |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
| <a name="input_region1"></a> [region1](#input\_region1) | n/a | `string` | `"cn-chengdu"` | no |
| <a name="input_region2"></a> [region2](#input\_region2) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_region3"></a> [region3](#input\_region3) | n/a | `string` | `"cn-qingdao"` | no |
| <a name="input_system_disk_category"></a> [system\_disk\_category](#input\_system\_disk\_category) | n/a | `string` | `"cloud_essd"` | no |
| <a name="input_vpc1_cidr"></a> [vpc1\_cidr](#input\_vpc1\_cidr) | n/a | `string` | `"172.16.0.0/16"` | no |
| <a name="input_vpc2_cidr"></a> [vpc2\_cidr](#input\_vpc2\_cidr) | n/a | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc3_cidr"></a> [vpc3\_cidr](#input\_vpc3\_cidr) | n/a | `string` | `"192.168.0.0/16"` | no |
| <a name="input_vsw11_cidr"></a> [vsw11\_cidr](#input\_vsw11\_cidr) | n/a | `string` | `"172.16.20.0/24"` | no |
| <a name="input_vsw12_cidr"></a> [vsw12\_cidr](#input\_vsw12\_cidr) | n/a | `string` | `"172.16.21.0/24"` | no |
| <a name="input_vsw21_cidr"></a> [vsw21\_cidr](#input\_vsw21\_cidr) | n/a | `string` | `"10.0.20.0/24"` | no |
| <a name="input_vsw22_cidr"></a> [vsw22\_cidr](#input\_vsw22\_cidr) | n/a | `string` | `"10.0.21.0/24"` | no |
| <a name="input_vsw31_cidr"></a> [vsw31\_cidr](#input\_vsw31\_cidr) | n/a | `string` | `"192.168.20.0/24"` | no |
| <a name="input_vsw32_cidr"></a> [vsw32\_cidr](#input\_vsw32\_cidr) | n/a | `string` | `"192.168.21.0/24"` | no |
| <a name="input_zone11_id"></a> [zone11\_id](#input\_zone11\_id) | n/a | `string` | `"cn-chengdu-a"` | no |
| <a name="input_zone12_id"></a> [zone12\_id](#input\_zone12\_id) | n/a | `string` | `"cn-chengdu-b"` | no |
| <a name="input_zone21_id"></a> [zone21\_id](#input\_zone21\_id) | n/a | `string` | `"cn-shanghai-e"` | no |
| <a name="input_zone22_id"></a> [zone22\_id](#input\_zone22\_id) | n/a | `string` | `"cn-shanghai-f"` | no |
| <a name="input_zone31_id"></a> [zone31\_id](#input\_zone31\_id) | n/a | `string` | `"cn-qingdao-c"` | no |
| <a name="input_zone32_id"></a> [zone32\_id](#input\_zone32\_id) | n/a | `string` | `"cn-qingdao-b"` | no |
<!-- END_TF_DOCS -->