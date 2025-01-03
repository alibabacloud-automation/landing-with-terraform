variable "name" {
  default = "tf-example"
}
data "alicloud_nlb_zones" "default" {
}

resource "alicloud_vpc" "create_vpc" {
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "create_vsw_j" {
  vpc_id     = alicloud_vpc.create_vpc.id
  zone_id    = data.alicloud_nlb_zones.default.zones.0.id
  cidr_block = "172.16.1.0/24"
}

resource "alicloud_vswitch" "create_vsw_k" {
  vpc_id     = alicloud_vpc.create_vpc.id
  zone_id    = data.alicloud_nlb_zones.default.zones.1.id
  cidr_block = "172.16.2.0/24"
}

resource "alicloud_nlb_load_balancer" "lb" {
  address_ip_version = "Ipv4"
  zone_mappings {
    vswitch_id = alicloud_vswitch.create_vsw_j.id
    zone_id    = alicloud_vswitch.create_vsw_j.zone_id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.create_vsw_k.id
    zone_id    = alicloud_vswitch.create_vsw_k.zone_id
  }
  load_balancer_type = "Network"
  load_balancer_name = var.name

  vpc_id       = alicloud_vpc.create_vpc.id
  address_type = "Internet"
}

resource "alicloud_nlb_server_group" "create_sg" {
  address_ip_version = "Ipv4"
  scheduler          = "Wrr"
  health_check {
  }
  server_group_type = "Instance"
  vpc_id            = alicloud_vpc.create_vpc.id
  protocol          = "TCPSSL"
  server_group_name = var.name

}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ssl_certificates_service_certificate" "ssl0" {
  cert             = <<EOF
-----BEGIN CERTIFICATE-----
MIIDhDCCAmwCCQCwJW4JChLBqTANBgkqhkiG9w0BAQsFADCBgzELMAkGA1UEBhMC
Q04xEDAOBgNVBAgMB0JlaWppbmcxEDAOBgNVBAcMB0JlaWppbmcxDDAKBgNVBAoM
A0FsaTEPMA0GA1UECwwGQWxpeXVuMRIwEAYDVQQDDAlUZXJyYWZvcm0xHTAbBgkq
hkiG9w0BCQEWDjEyM0BhbGl5dW0uY29tMB4XDTI0MTIyNTA3MjQ0OFoXDTI3MTIy
NTA3MjQ0OFowgYMxCzAJBgNVBAYTAkNOMRAwDgYDVQQIDAdCZWlqaW5nMRAwDgYD
VQQHDAdCZWlqaW5nMQwwCgYDVQQKDANBbGkxDzANBgNVBAsMBkFsaXl1bjESMBAG
A1UEAwwJVGVycmFmb3JtMR0wGwYJKoZIhvcNAQkBFg4xMjNAYWxpeXVtLmNvbTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK4UufXydtJZeW6lX9VahVIk
ifblYCVkFcFoderF2FtD5AeMZJ+v+chHc7RiV+U7P3o0Fzk+cg7OL9dSEYBrwHK4
9yCwU/Mv+I/KsS8GjrRMOPjbrYvI0GjheEPJcILbt29tygrxX2PwV6FqWNknbGpk
Ej8L9zTL977IHBmgw8A2AeKlqV64s8ydAgGbWO3NTK64OlEJJNR+J+75uYskNT3s
8DqaQV/IWlGAiUmGVeorWkrAWCfx2zSwI9jU8pNHtSF7PyxlbRy1ir2Lv1WnQKHf
Bnhr/wXwKOL5IJRVZ144Z9TdcoPo4GbFmYMSTwYFIbjYZ3yxoygeXMk0UXPZxVsC
AwEAATANBgkqhkiG9w0BAQsFAAOCAQEAVPA+Q0/5T6VzVw+MFXjCxXH1mWgd767w
YWX4tvdGsTDkK6/ESm8m9GDp5F3p7Degk0isr9XkyzkWo/nPEPWQOeYR0kNTvpwY
mKz9/aJwxalHS6O/8K2Ed6pZcXW0SUfjdH0/9YHw+vu4i2cQGTICzrKuEvyck40y
fQocvFyw6O7W+tewLA4ntTuC6HhEQbC0p7zxGc3LSuayBgJrJiOAnGvFu+/OFQi+
zEXi1xt8uQR6q5DQDsfqNCxpRKsCmU+POzNg2Y31GDMv4ZPerou5jXa1gh8/TVBT
IX3OTy5aL4Ue8nBip3bVw+V/9L9xhmXbex6IMwwvrWI4OfMt6ECifQ==
-----END CERTIFICATE-----
EOF
  certificate_name = join("-", [var.name, random_integer.default.result, 0])

  key = <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEArhS59fJ20ll5bqVf1VqFUiSJ9uVgJWQVwWh16sXYW0PkB4xk
n6/5yEdztGJX5Ts/ejQXOT5yDs4v11IRgGvAcrj3ILBT8y/4j8qxLwaOtEw4+Nut
i8jQaOF4Q8lwgtu3b23KCvFfY/BXoWpY2SdsamQSPwv3NMv3vsgcGaDDwDYB4qWp
XrizzJ0CAZtY7c1Mrrg6UQkk1H4n7vm5iyQ1PezwOppBX8haUYCJSYZV6itaSsBY
J/HbNLAj2NTyk0e1IXs/LGVtHLWKvYu/VadAod8GeGv/BfAo4vkglFVnXjhn1N1y
g+jgZsWZgxJPBgUhuNhnfLGjKB5cyTRRc9nFWwIDAQABAoIBAC0D2Q6bc1RzpK4S
/5QZQ055el+o8tLYbbPEwnFCVe9LwASfrkmI5OuAZpAnuhjh2ElOfQ7lcfMYKFDi
vPnbYzmHUQhX8G17YygzvtutM2u2JilcDSWPeS0V2NaWmYyNKoMa/dsUjZk3RkHM
UUteIW/ljr5U5sj1UYw5DOMnqlbicy2cPPY4g1QKGW5t3p5Lxw5ojgqynzi8EKMq
j0apEoTXxmciOrwwiP2ynRTEN77+FUZkTvmxmSPoIfNTycDPRr4aUwVHV2d5FHPn
d1MdjSoUPbHdOLfynwXqTz9OlvMSUDrBvs6k5ripGY9qvh9PrOdj7zLXVRQXUuOR
YwoVHKECgYEA1NzNGifjW5cdcbkzc86QA9TM7yAyBmgnopzlm+dFIhxtJmydxN4V
820x1Lkfe2vLCyYQ6fcEKAtjC9qdw+E2uzHAbtvnR4JseF3z1D82xw3MgGT9l3zc
mMrgKmdCGGLWi6hboylX+2GBMVl2R0aRZrZje67jZcDXd06mlvW257ECgYEA0Vv1
X3Ubn8XA3AA1ybem8fWNwEXfcYP1lJq0cX1gUXlpQvxWN61//aFZUCJZw5cEPArQ
rEqhT81VCqXGO/by6D3fJD+4P8D6v6szJK2AGvXkZMfnJwAbHcOyGlxMin1CTJss
ZID0XI9xmbedm7Wi40+qXz8q4rs25kft9YjfzMsCgYBSPfE8vtaYJ52nt7+Kae+4
mzqG1XCeixVtPaN1BfjvAf6mDucyDgB7KeBL6S6ht/ceGpoEW30On7+n79JuwRAt
aT6JVotYVKrmIp63jajzZYByxxI3unVcz12m5HhkBaQRF344XxvwMy8ASyloxnod
LjDns52GTeix3wB8aPk/MQKBgGOQRwXpjISUKB64HtxacZN6ArqgwB2c8uqEFDIw
vOCiS7Pmix4ZbdfxpqbcXzIMHKBtSEXXjBWGgd35bmfQDj7yRa9Yekgff2Ati7ny
pQytSbu/8abzfvHNwmKU6HWoEiKaXSdCyHNIaG8BCnwlilxt44k+YifHftlO9dSi
DkS3AoGAYmF++8uEvQot5Yma4GraY+7ZyfWNLwClsOsrN2g19Vycg16fJk0olwDx
2kRWKqNn99HJJwiLie1nvsDRJLbmzmI91Pttpu/EYFDJ8OYQOr1OhhPwwTygf+7S
1o2RTXu3gKNG6fxOtHFatws3IzvovOASYyJR5XP2sIJURLOrSN0=
-----END RSA PRIVATE KEY-----
EOF
}

resource "alicloud_nlb_listener" "create_listener" {
  listener_port      = "443"
  server_group_id    = alicloud_nlb_server_group.create_sg.id
  load_balancer_id   = alicloud_nlb_load_balancer.lb.id
  listener_protocol  = "TCPSSL"
  certificate_ids    = ["${alicloud_ssl_certificates_service_certificate.ssl0.id}-cn-hangzhou"]
  ca_certificate_ids = []
}

resource "alicloud_ssl_certificates_service_certificate" "ssl" {
  cert             = <<EOF
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
  certificate_name = join("-", [var.name, random_integer.default.result, 1])

  key = <<EOF
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

resource "alicloud_nlb_listener_additional_certificate_attachment" "default" {
  certificate_id = alicloud_ssl_certificates_service_certificate.ssl.id
  listener_id    = alicloud_nlb_listener.create_listener.id
}