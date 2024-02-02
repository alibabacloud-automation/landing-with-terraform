resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_cdn_domain_new" "default" {
  scope       = "overseas"
  domain_name = "mycdndomain-${random_integer.default.result}.alicloud-provider.cn"
  cdn_type    = "web"
  sources {
    type     = "ipaddr"
    content  = "1.1.1.1"
    priority = 20
    port     = 80
    weight   = 15
  }
}