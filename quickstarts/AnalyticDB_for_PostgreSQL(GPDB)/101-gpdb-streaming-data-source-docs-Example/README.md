## Introduction

This example is used to create a `alicloud_gpdb_streaming_data_source` resource.

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
| [alicloud_gpdb_instance.default7mX6ld](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/gpdb_instance) | resource |
| [alicloud_gpdb_streaming_data_service.defaultwruvdv](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/gpdb_streaming_data_service) | resource |
| [alicloud_gpdb_streaming_data_source.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/gpdb_streaming_data_source) | resource |
| [alicloud_vpc.defaultDfkYOR](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default59ZqyD](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kafka-config"></a> [kafka-config](#input\_kafka-config) | n/a | `string` | `"{\n    \"brokers\": \"alikafka-post-cn-g4t3t4eod004-1-vpc.alikafka.aliyuncs.com:9092,alikafka-post-cn-g4t3t4eod004-2-vpc.alikafka.aliyuncs.com:9092,alikafka-post-cn-g4t3t4eod004-3-vpc.alikafka.aliyuncs.com:9092\",\n    \"delimiter\": \"|\",\n    \"format\": \"delimited\",\n    \"topic\": \"ziyuan_example\"\n}\n"` | no |
| <a name="input_kafka-config-modify"></a> [kafka-config-modify](#input\_kafka-config-modify) | n/a | `string` | `"{\n    \"brokers\": \"alikafka-post-cn-g4t3t4eod004-1-vpc.alikafka.aliyuncs.com:9092,alikafka-post-cn-g4t3t4eod004-2-vpc.alikafka.aliyuncs.com:9092,alikafka-post-cn-g4t3t4eod004-3-vpc.alikafka.aliyuncs.com:9092\",\n    \"delimiter\": \"#\",\n    \"format\": \"delimited\",\n    \"topic\": \"ziyuan_example\"\n}\n"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->
