## Introduction

This example is used to create a `alicloud_bastionhost_host_account_share_key_attachment` resource.

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
| [alicloud_bastionhost_host.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/bastionhost_host) | resource |
| [alicloud_bastionhost_host_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/bastionhost_host_account) | resource |
| [alicloud_bastionhost_host_account_share_key_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/bastionhost_host_account_share_key_attachment) | resource |
| [alicloud_bastionhost_host_share_key.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/bastionhost_host_share_key) | resource |
| [alicloud_bastionhost_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/bastionhost_instance) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpcs.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpcs) | data source |
| [alicloud_vswitches.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vswitches) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | n/a | `string` | `"LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBc25oc29SSVVwVXltSG1FVHJXUGxDbkhMa3c3N0JYTm44ZHcvbDg3eG10SUhjd2syCkRybjFDZk5jZkpJV0tSdkFaYkdKMlZTS1RiRDhPTmcyT3JvUHFGUHBLOHJ5QjJRb1NYQVRsaUVHWFhNeW1tRm8KeDBmem12THFscUxpNGZnOExhcTc5UC85aGxLU1djTWhJU0pYVTNHMS9KdEFBUmEyQXc4cXEzSVQvMkZ5NktrdwowMU9MdDdLN2pGUFRPaHhtdmNoSkZ1SVo1YXI0cW5HUlFHQnpCL2hoRHVIWEMwRlhJZ2ozd0NXMDZ4R2V2WjJyCmNCWWwwN1luL2lvZk95MU0wRjZZN0JrMU95N21vYndzM1JsalUyL2FpZlhLMmNOUlk2Qjl5WXNvd1RBZmQ5OTQKQ2YxSlF3TlhsaUZCeTZueEJLQk1YbDhIU1grS1o3L29PUlIwVXdJREFRQUJBb0lCQVFDbU5JSXR5ckhSY3oxdApJMGo0L0FQc295ZE1EL0owRkJMa2FoSUxKWjFaYW1tbmx4ZHh4WHBQUndXRnVXTEw2OTFVbDI5aUoxb1ptazU1Ci9ka2EvZlhnOUN3OUxXWVN2aExLdVlaMEZOTmhxZ3VoUEVBZy9uLytlR1ZCM2ZYZkxaZVZpK0E0L1VHMG15ZFMKVXVlQ2ZRSElZeWh4VkgvWnc3WER5WmNhVFVZVVdMUWlYcVN0Y2JRbnZFOXpwOGc5TWh5UkhBcWYwbEt2UTRqdwphUnNKTnlob3lhZWcvUXlFeHVYNGdBR1lIc1lTSDRFVmtXOHl5WE1aOHpRdk1OSUNiYXhmUkRuSngybUh6a09rCnFHczVXbFp5L3VrQk5jWTQwd2Y0eTY2bEVJaVpKbiswaFhtSTF4Tk5SdHRwMjZnY3ROOXZWbmVicTdLTnpjTDgKeFQrMXZJaEpBb0dCQU9iMVM1YlE4NVRFWDBoZTRmdXc2R3ExbnhRLzJUSU03emZhK2VhZThPQlh2eVNFV3JpdwpPZzM3RFhVUDFNVU1iTEJRenE0STl1dE5YSVZadEFLR0h6ZDR6WmtQeGxORjZPN0FyWnJEWElDNEdKZHdmSEhxCjJZcDkxUDlWekJlOVhkTVdZVGFCNkMzWVdtYzQwM08vYWdyRCtNb2JnL0hqMSt0d2xZR2hjdlV2QW9HQkFNWFMKT2VnWHc5VUF3VEZabFBtZzZKeDI3TzNXUFBHd1E3QzRnYitFZzZkR1pLRnJVR1ZId2VUUG1HaGtwN1BmYU5ESwplaFVoUWFnNm9XOTF4dkE2YldZZ29SQmczUWkxc01MblRWeTExeVN1UEVFSCtMT2s1N3d2akNLSk5XZnM0SjVyCmg1NGw0QXZ6UVhyWWN0UlZkSmYrNjFacGFnTkdZMVBvWVJMTHJMSWRBb0dBTndydzErRzJtNWJ0YW04S2hwU1QKMzVLbmRnajlkM3N6cStrcE03aGZpZWYvcXZGTU9jWHVJQlRjRVRFVHNWNlRyTFdsZkQ2d3NrVitybDFCbEhSbwpqaXpoT3dCU2NOZ3hlbTA3TXE0cXBwYTViYVltVW5QNUlwTjRwdDNJeFVPaFQ4UitxS0h2TnJYZ1hjZGlSYXl4CjFoejhkeFoxckxselpTNHd3M001MVlzQ2dZRUFpUDEwTEUySXg5Q2wrTTdZWTZZU2I0Zkx1MGhKRy9XOGFuemIKSFExZlBrOTVFRytJVlJyRUl2ZS95MHNvOTE4VzdyL0lteWxVbG5ORHFEUWZkK3grSmVNaXBuenRsRUorRGZxdgprQ3c4dUtJUUI5akZXV0l4T0JpVktyVnB6bll6ZG9Gd2dRd3BneDBKazFDZzlIblpMQWpVWUJyUDEwUy9ORFFRClJUdldjK0VDZ1lBeGRIZWxQNG1RdkJaS1oxMlNKbHlLbFVLeW43aHhzSHVkMkphMVNtS3FWeHBERDNlR0w0Y3QKZXA1QTZ5NkF4eGViZkI0aDdYNEZ0QTBBRURPdkZDR0J1QlRvZ3ZBdUNDVUtqK2JIUG1SNG53UVYzcWZ2M3loRAp0TGkwU2FHVElta2wvbUNCUDhZaW9JUys2N0xjby9kbHphUTNGVDlxTnJieFdFWjJlaS9LVlE9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQ=="` | no |
<!-- END_TF_DOCS -->    