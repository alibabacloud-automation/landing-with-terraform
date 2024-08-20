provider "alicloud" {
  region = "cn-shanghai"
}

variable "name" {
  default = "flask-6ew9.fcv3.1511928242963727.cn-shanghai.fc.devsapp.net"
}

variable "function_name1" {
  default = "terraform-custom-domain-t1"
}

variable "auth_config" {
  default = <<EOF
{
    "jwks": {
        "keys": [
            {
                "p": "8AdUVeldoE4LueFuzEF_C8tvJ7NhlkzS58Gz9KJTPXPr5DADSUVLWJCr5OdFE79q513SneT0UhGo-JfQ1lNMoNv5-YZ1AxIo9fZUEPIe-KyX9ttaglpzCAUE3TeKdm5J-_HZQzBPKbyUwJHAILNgB2-4IBZZwK7LAfbmfi9TmFM",
                "kty": "RSA",
                "q": "x8m5ydXwC8AAp9I-hOnUAx6yQJz1Nx-jXPCfn--XdHpJuNcuwRQsuUCSRQs_h3SoCI3qZZdzswQnPrtHFxgUJtQFuMj-QZpyMnebDb81rmczl2KPVUtaVDVagJEF6U9Ov3PfrLhvHUEv5u7p6s4Z6maBUaByfFlhEVPv4_ao8Us",
                "d": "bjIQAKD2e65gwJ38_Sqq_EmLFuMMey3gjDv1bSCHFH8fyONJTq-utrZfvspz6EegRwW2mSHW9kq87hRwIBW9y7ED5N4KG5gHDjyh57BRE0SKv0Dz1igtKLyp-nl8-aHc1DbONwr1d7tZfFt255TxIN8cPTakXOp2Av_ztql_JotVUGK8eHmXNJFlvq5tc180sKWMHNSNsCUhQgcB1TWb_gwcqxdsIWPsLZI491XKeTGQ98J7z5h6R1cTC97lfJZ0vNtJahd2jHd3WfTUDj5-untMKyZpYYak2Vr8xtFz8H6Q5Rsz8uX_7gtEqYH2CMjPdbXcebrnD1igRSJMYiP0lQ",
                "e": "AQAB",
                "use": "sig",
                "qi": "MTCCRu8AcvvjbHms7V_sDFO7wX0YNyvOJAAbuTmHvQbJ0NDeDta-f-hi8cjkMk7Fpk2hej158E5gDyO62UG99wHZSbmHT34MvIdmhQ5mnbL-5KK9rxde0nayO1ebGepD_GJThPAg9iskzeWpCg5X2etNo2bHoG_ZLQGXj2BQ1VM",
                "dp": "J4_ttKNcTTnP8PlZO81n1VfYoGCOqylKceyZbq76rVxX-yp2wDLtslFWI8qCtjiMtEnglynPo19JzH-pakocjT70us4Qp0rs-W16ebiOpko8WfHZvzaNUzsQjC3FYrPW-fHo74wc4DI3Cm57jmhCYbdmT9OfQ4UL7Oz3HMFMNAU",
                "alg": "RS256",
                "dq": "H4-VgvYB-sk1EU3cRIDv1iJWRHDHKBMeaoM0pD5kLalX1hRgNW4rdoRl1vRk79AU720D11Kqm2APlxBctaA_JrcdxEg0KkbsvV45p11KbKeu9b5DKFVECsN27ZJ7XZUCuqnibtWf7_4pRBD_8PDoFShmS2_ORiiUdflNjzSbEas",
                "n": "u1LWgoomekdOMfB1lEe96OHehd4XRNCbZRm96RqwOYTTc28Sc_U5wKV2umDzolfoI682ct2BNnRRahYgZPhbOCzHYM6i8sRXjz9Ghx3QHw9zrYACtArwQxrTFiejbfzDPGdPrMQg7T8wjtLtkSyDmCzeXpbIdwmxuLyt_ahLfHelr94kEksMDa42V4Fi5bMW4cCLjlEKzBEHGmFdT8UbLPCvpgsM84JK63e5ifdeI9NdadbC8ZMiR--dFCujT7AgRRyMzxgdn2l-nZJ2ZaYzbLUtAW5_U2kfRVkDNa8d1g__2V5zjU6nfLJ1S2MoXMgRgDPeHpEehZVu2kNaSFvDUQ"
            }
        ]
    },
    "tokenLookup": "header:auth",
    "claimPassBy": "header:name:name"
}
EOF
}

variable "certificate" {
  default = <<EOF
-----BEGIN CERTIFICATE-----
MIIDRjCCAq+gAwIBAgIJAJn3ox4K13PoMA0GCSqGSIb3DQEBBQUAMHYxCzAJBgNV
BAYTAkNOMQswCQYDVQQIEwJCSjELMAkGA1UEBxMCQkoxDDAKBgNVBAoTA0FMSTEP
MA0GA1UECxMGQUxJWVVOMQ0wCwYDVQQDEwR0ZXN0MR8wHQYJKoZIhvcNAQkBFhB0
ZXN0QGhvdG1haWwuY29tMB4XDTE0MTEyNDA2MDQyNVoXDTI0MTEyMTA2MDQyNVow
djELMAkGA1UEBhMCQ04xCzAJBgNVBAgTAkJKMQswCQYDVQQHEwJCSjEMMAoGA1UE
ChMDQUxJMQ8wDQYDVQQLEwZBTElZVU4xDTALBgNVBAMTBHRlc3QxHzAdBgkqhkiG
9w0BCQEWEHRlc3RAaG90bWFpbC5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJ
AoGBAM7SS3e9+Nj0HKAsRuIDNSsS3UK6b+62YQb2uuhKrp1HMrOx61WSDR2qkAnB
coG00Uz38EE+9DLYNUVQBK7aSgLP5M1Ak4wr4GqGyCgjejzzh3DshUzLCCy2rook
KOyRTlPX+Q5l7rE1fcSNzgepcae5i2sE1XXXzLRIDIvQxcspAgMBAAGjgdswgdgw
HQYDVR0OBBYEFBdy+OuMsvbkV7R14f0OyoLoh2z4MIGoBgNVHSMEgaAwgZ2AFBdy
+OuMsvbkV7R14f0OyoLoh2z4oXqkeDB2MQswCQYDVQQGEwJDTjELMAkGA1UECBMC
QkoxCzAJBgNVBAcTAkJKMQwwCgYDVQQKEwNBTEkxDzANBgNVBAsTBkFMSVlVTjEN
MAsGA1UEAxMEdGVzdDEfMB0GCSqGSIb3DQEJARYQdGVzdEBob3RtYWlsLmNvbYIJ
AJn3ox4K13PoMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEFBQADgYEAY7KOsnyT
cQzfhiiG7ASjiPakw5wXoycHt5GCvLG5htp2TKVzgv9QTliA3gtfv6oV4zRZx7X1
Ofi6hVgErtHaXJheuPVeW6eAW8mHBoEfvDAfU3y9waYrtUevSl07643bzKL6v+Qd
DUBTxOAvSYfXTtI90EAxEG/bJJyOm5LqoiA=
-----END CERTIFICATE-----
EOF
}

variable "private_key" {
  default = <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDO0kt3vfjY9BygLEbiAzUrEt1Cum/utmEG9rroSq6dRzKzsetV
kg0dqpAJwXKBtNFM9/BBPvQy2DVFUASu2koCz+TNQJOMK+BqhsgoI3o884dw7IVM
ywgstq6KJCjskU5T1/kOZe6xNX3Ejc4HqXGnuYtrBNV118y0SAyL0MXLKQIDAQAB
AoGAfe3NxbsGKhN42o4bGsKZPQDfeCHMxayGp5bTd10BtQIE/ST4BcJH+ihAS7Bd
6FwQlKzivNd4GP1MckemklCXfsVckdL94e8ZbJl23GdWul3v8V+KndJHqv5zVJmP
hwWoKimwIBTb2s0ctVryr2f18N4hhyFw1yGp0VxclGHkjgECQQD9CvllsnOwHpP4
MdrDHbdb29QrobKyKW8pPcDd+sth+kP6Y8MnCVuAKXCKj5FeIsgVtfluPOsZjPzz
71QQWS1dAkEA0T0KXO8gaBQwJhIoo/w6hy5JGZnrNSpOPp5xvJuMAafs2eyvmhJm
Ev9SN/Pf2VYa1z6FEnBaLOVD6hf6YQIsPQJAX/CZPoW6dzwgvimo1/GcY6eleiWE
qygqjWhsh71e/3bz7yuEAnj5yE3t7Zshcp+dXR3xxGo0eSuLfLFxHgGxwQJAAxf8
9DzQ5NkPkTCJi0sqbl8/03IUKTgT6hcbpWdDXa7m8J3wRr3o5nUB+TPQ5nzAbthM
zWX931YQeACcwhxvHQJBAN5mTzzJD4w4Ma6YTaNHyXakdYfyAWrOkPIWZxfhMfXe
DrlNdiysTI4Dd1dLeErVpjsckAaOW/JDG5PCSwkaMxk=
-----END RSA PRIVATE KEY-----
EOF
}

resource "alicloud_fcv3_custom_domain" "default" {
  custom_domain_name = "flask-6ew9.fcv3.1511928242963727.cn-shanghai.fc.devsapp.net"
  route_config {
    routes {
      function_name = var.function_name1
      rewrite_config {
        regex_rules {
          match       = "/api/*"
          replacement = "$1"
        }
        regex_rules {
          match       = "/api1/*"
          replacement = "$1"
        }
        regex_rules {
          match       = "/api2/*"
          replacement = "$1"
        }

        wildcard_rules {
          match       = "^/api1/.+?/(.*)"
          replacement = "/api/v1/$1"
        }
        wildcard_rules {
          match       = "^/api2/.+?/(.*)"
          replacement = "/api/v2/$1"
        }
        wildcard_rules {
          match       = "^/api2/.+?/(.*)"
          replacement = "/api/v3/$1"
        }

        equal_rules {
          match       = "/old"
          replacement = "/new"
        }
        equal_rules {
          replacement = "/new1"
          match       = "/old1"
        }
        equal_rules {
          match       = "/old2"
          replacement = "/new2"
        }

      }

      methods = [
        "GET",
        "POST",
        "DELETE",
        "HEAD"
      ]
      path      = "/a"
      qualifier = "LATEST"
    }
    routes {
      function_name = var.function_name1
      methods = [
        "GET"
      ]
      path      = "/b"
      qualifier = "LATEST"
    }
    routes {
      function_name = var.function_name1
      methods = [
        "POST"
      ]
      path      = "/c"
      qualifier = "1"
    }

  }

  auth_config {
    auth_type = "jwt"
    auth_info = var.auth_config
  }

  protocol = "HTTP,HTTPS"
  cert_config {
    cert_name   = "cert-name"
    certificate = var.certificate
    private_key = var.private_key
  }

  tls_config {
    cipher_suites = [
      "TLS_RSA_WITH_AES_128_CBC_SHA",
      "TLS_RSA_WITH_AES_256_CBC_SHA",
      "TLS_RSA_WITH_AES_128_GCM_SHA256",
      "TLS_RSA_WITH_AES_256_GCM_SHA384"
    ]
    max_version = "TLSv1.3"
    min_version = "TLSv1.0"
  }

  waf_config {
    enable_waf = "false"
  }

}