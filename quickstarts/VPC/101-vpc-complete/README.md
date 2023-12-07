<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_vpc` resource.

## Requirements

Before using this example, you first need to create the following dependency resources.
- `alicloud_resource_manager_resource_groups`

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The CIDR block for the VPC. The `cidr_block` is Optional and default value is `172.16.0.0/12` after v1.119.0+. | `string` | `"172.16.0.0/12"` | no |
| <a name="input_classic_link_enabled"></a> [classic\_link\_enabled](#input\_classic\_link\_enabled) | The status of ClassicLink function. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The VPC description. Defaults to null. | `string` | `"tf-example"` | no |
| <a name="input_dry_run"></a> [dry\_run](#input\_dry\_run) | Whether to PreCheck this request only. Value:<br>-**true**: sends a check request and does not create a VPC. Check items include whether required parameters, request format, and business restrictions have been filled in. If the check fails, the corresponding error is returned. If the check passes, the error code 'DryRunOperation' is returned '.<br>-**false** (default): Sends a normal request, returns the HTTP 2xx status code after the check, and directly creates a VPC. | `bool` | `false` | no |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Whether to enable the IPv6 network segment. Value:<br><br>-**false** (default): not enabled.<br>-**true**: on. | `bool` | `true` | no |
| <a name="input_ipv6_isp"></a> [ipv6\_isp](#input\_ipv6\_isp) | The IPv6 address segment type of the VPC. Value:<br><br>-**BGP** (default): Alibaba Cloud BGP IPv6.<br>-**ChinaMobile**: China Mobile (single line).<br>-**ChinaUnicom**: China Unicom (single line).<br>-**ChinaTelecom**: China Telecom (single line).<br><br>> If a single-line bandwidth whitelist is enabled, this field can be set to **ChinaTelecom** (China Telecom), **ChinaUnicom** (China Unicom), or **ChinaMobile** (China Mobile). | `string` | `"BGP"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC. Defaults to null. | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    