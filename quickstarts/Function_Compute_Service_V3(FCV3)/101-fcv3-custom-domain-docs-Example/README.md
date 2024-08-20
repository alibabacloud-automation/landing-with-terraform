## Introduction

This example is used to create a `alicloud_fcv3_custom_domain` resource.

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
| [alicloud_fcv3_custom_domain.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fcv3_custom_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_config"></a> [auth\_config](#input\_auth\_config) | n/a | `string` | `"{\n    \"jwks\": {\n        \"keys\": [\n            {\n                \"p\": \"8AdUVeldoE4LueFuzEF_C8tvJ7NhlkzS58Gz9KJTPXPr5DADSUVLWJCr5OdFE79q513SneT0UhGo-JfQ1lNMoNv5-YZ1AxIo9fZUEPIe-KyX9ttaglpzCAUE3TeKdm5J-_HZQzBPKbyUwJHAILNgB2-4IBZZwK7LAfbmfi9TmFM\",\n                \"kty\": \"RSA\",\n                \"q\": \"x8m5ydXwC8AAp9I-hOnUAx6yQJz1Nx-jXPCfn--XdHpJuNcuwRQsuUCSRQs_h3SoCI3qZZdzswQnPrtHFxgUJtQFuMj-QZpyMnebDb81rmczl2KPVUtaVDVagJEF6U9Ov3PfrLhvHUEv5u7p6s4Z6maBUaByfFlhEVPv4_ao8Us\",\n                \"d\": \"bjIQAKD2e65gwJ38_Sqq_EmLFuMMey3gjDv1bSCHFH8fyONJTq-utrZfvspz6EegRwW2mSHW9kq87hRwIBW9y7ED5N4KG5gHDjyh57BRE0SKv0Dz1igtKLyp-nl8-aHc1DbONwr1d7tZfFt255TxIN8cPTakXOp2Av_ztql_JotVUGK8eHmXNJFlvq5tc180sKWMHNSNsCUhQgcB1TWb_gwcqxdsIWPsLZI491XKeTGQ98J7z5h6R1cTC97lfJZ0vNtJahd2jHd3WfTUDj5-untMKyZpYYak2Vr8xtFz8H6Q5Rsz8uX_7gtEqYH2CMjPdbXcebrnD1igRSJMYiP0lQ\",\n                \"e\": \"AQAB\",\n                \"use\": \"sig\",\n                \"qi\": \"MTCCRu8AcvvjbHms7V_sDFO7wX0YNyvOJAAbuTmHvQbJ0NDeDta-f-hi8cjkMk7Fpk2hej158E5gDyO62UG99wHZSbmHT34MvIdmhQ5mnbL-5KK9rxde0nayO1ebGepD_GJThPAg9iskzeWpCg5X2etNo2bHoG_ZLQGXj2BQ1VM\",\n                \"dp\": \"J4_ttKNcTTnP8PlZO81n1VfYoGCOqylKceyZbq76rVxX-yp2wDLtslFWI8qCtjiMtEnglynPo19JzH-pakocjT70us4Qp0rs-W16ebiOpko8WfHZvzaNUzsQjC3FYrPW-fHo74wc4DI3Cm57jmhCYbdmT9OfQ4UL7Oz3HMFMNAU\",\n                \"alg\": \"RS256\",\n                \"dq\": \"H4-VgvYB-sk1EU3cRIDv1iJWRHDHKBMeaoM0pD5kLalX1hRgNW4rdoRl1vRk79AU720D11Kqm2APlxBctaA_JrcdxEg0KkbsvV45p11KbKeu9b5DKFVECsN27ZJ7XZUCuqnibtWf7_4pRBD_8PDoFShmS2_ORiiUdflNjzSbEas\",\n                \"n\": \"u1LWgoomekdOMfB1lEe96OHehd4XRNCbZRm96RqwOYTTc28Sc_U5wKV2umDzolfoI682ct2BNnRRahYgZPhbOCzHYM6i8sRXjz9Ghx3QHw9zrYACtArwQxrTFiejbfzDPGdPrMQg7T8wjtLtkSyDmCzeXpbIdwmxuLyt_ahLfHelr94kEksMDa42V4Fi5bMW4cCLjlEKzBEHGmFdT8UbLPCvpgsM84JK63e5ifdeI9NdadbC8ZMiR--dFCujT7AgRRyMzxgdn2l-nZJ2ZaYzbLUtAW5_U2kfRVkDNa8d1g__2V5zjU6nfLJ1S2MoXMgRgDPeHpEehZVu2kNaSFvDUQ\"\n            }\n        ]\n    },\n    \"tokenLookup\": \"header:auth\",\n    \"claimPassBy\": \"header:name:name\"\n}\n"` | no |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | n/a | `string` | `"-----BEGIN CERTIFICATE-----\nMIIDRjCCAq+gAwIBAgIJAJn3ox4K13PoMA0GCSqGSIb3DQEBBQUAMHYxCzAJBgNV\nBAYTAkNOMQswCQYDVQQIEwJCSjELMAkGA1UEBxMCQkoxDDAKBgNVBAoTA0FMSTEP\nMA0GA1UECxMGQUxJWVVOMQ0wCwYDVQQDEwR0ZXN0MR8wHQYJKoZIhvcNAQkBFhB0\nZXN0QGhvdG1haWwuY29tMB4XDTE0MTEyNDA2MDQyNVoXDTI0MTEyMTA2MDQyNVow\ndjELMAkGA1UEBhMCQ04xCzAJBgNVBAgTAkJKMQswCQYDVQQHEwJCSjEMMAoGA1UE\nChMDQUxJMQ8wDQYDVQQLEwZBTElZVU4xDTALBgNVBAMTBHRlc3QxHzAdBgkqhkiG\n9w0BCQEWEHRlc3RAaG90bWFpbC5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJ\nAoGBAM7SS3e9+Nj0HKAsRuIDNSsS3UK6b+62YQb2uuhKrp1HMrOx61WSDR2qkAnB\ncoG00Uz38EE+9DLYNUVQBK7aSgLP5M1Ak4wr4GqGyCgjejzzh3DshUzLCCy2rook\nKOyRTlPX+Q5l7rE1fcSNzgepcae5i2sE1XXXzLRIDIvQxcspAgMBAAGjgdswgdgw\nHQYDVR0OBBYEFBdy+OuMsvbkV7R14f0OyoLoh2z4MIGoBgNVHSMEgaAwgZ2AFBdy\n+OuMsvbkV7R14f0OyoLoh2z4oXqkeDB2MQswCQYDVQQGEwJDTjELMAkGA1UECBMC\nQkoxCzAJBgNVBAcTAkJKMQwwCgYDVQQKEwNBTEkxDzANBgNVBAsTBkFMSVlVTjEN\nMAsGA1UEAxMEdGVzdDEfMB0GCSqGSIb3DQEJARYQdGVzdEBob3RtYWlsLmNvbYIJ\nAJn3ox4K13PoMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEFBQADgYEAY7KOsnyT\ncQzfhiiG7ASjiPakw5wXoycHt5GCvLG5htp2TKVzgv9QTliA3gtfv6oV4zRZx7X1\nOfi6hVgErtHaXJheuPVeW6eAW8mHBoEfvDAfU3y9waYrtUevSl07643bzKL6v+Qd\nDUBTxOAvSYfXTtI90EAxEG/bJJyOm5LqoiA=\n-----END CERTIFICATE-----\n"` | no |
| <a name="input_function_name1"></a> [function\_name1](#input\_function\_name1) | n/a | `string` | `"terraform-custom-domain-t1"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"flask-6ew9.fcv3.1511928242963727.cn-shanghai.fc.devsapp.net"` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | n/a | `string` | `"-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQDO0kt3vfjY9BygLEbiAzUrEt1Cum/utmEG9rroSq6dRzKzsetV\nkg0dqpAJwXKBtNFM9/BBPvQy2DVFUASu2koCz+TNQJOMK+BqhsgoI3o884dw7IVM\nywgstq6KJCjskU5T1/kOZe6xNX3Ejc4HqXGnuYtrBNV118y0SAyL0MXLKQIDAQAB\nAoGAfe3NxbsGKhN42o4bGsKZPQDfeCHMxayGp5bTd10BtQIE/ST4BcJH+ihAS7Bd\n6FwQlKzivNd4GP1MckemklCXfsVckdL94e8ZbJl23GdWul3v8V+KndJHqv5zVJmP\nhwWoKimwIBTb2s0ctVryr2f18N4hhyFw1yGp0VxclGHkjgECQQD9CvllsnOwHpP4\nMdrDHbdb29QrobKyKW8pPcDd+sth+kP6Y8MnCVuAKXCKj5FeIsgVtfluPOsZjPzz\n71QQWS1dAkEA0T0KXO8gaBQwJhIoo/w6hy5JGZnrNSpOPp5xvJuMAafs2eyvmhJm\nEv9SN/Pf2VYa1z6FEnBaLOVD6hf6YQIsPQJAX/CZPoW6dzwgvimo1/GcY6eleiWE\nqygqjWhsh71e/3bz7yuEAnj5yE3t7Zshcp+dXR3xxGo0eSuLfLFxHgGxwQJAAxf8\n9DzQ5NkPkTCJi0sqbl8/03IUKTgT6hcbpWdDXa7m8J3wRr3o5nUB+TPQ5nzAbthM\nzWX931YQeACcwhxvHQJBAN5mTzzJD4w4Ma6YTaNHyXakdYfyAWrOkPIWZxfhMfXe\nDrlNdiysTI4Dd1dLeErVpjsckAaOW/JDG5PCSwkaMxk=\n-----END RSA PRIVATE KEY-----\n"` | no |
<!-- END_TF_DOCS -->
