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
| [alicloud_cs_serverless_kubernetes.serverless](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_serverless_kubernetes) | resource |
| [alicloud_security_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_eci_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/eci_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_name_prefix"></a> [k8s\_name\_prefix](#input\_k8s\_name\_prefix) | The name prefix used to create ASK cluster. | `string` | `"ask-example"` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | allowd values are [1.31.1-aliyun.1、1.30.1-aliyun.1、1.28.9-aliyun.1、1.26.15-aliyun.1、1.24.6-aliyun.1、1.22.15-aliyun.1、1.20.11-aliyun.1] | `string` | `"1.31.1-aliyun.1"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create ASK cluster](http://help.aliyun.com/document_detail/2391966.htm) 

<!-- docs-link --> 