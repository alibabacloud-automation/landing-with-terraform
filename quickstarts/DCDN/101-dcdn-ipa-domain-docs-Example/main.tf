resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_dcdn_ipa_domain" "example" {
  domain_name       = "example-${random_integer.default.result}.com"
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  scope             = "overseas"
  status            = "online"
  sources {
    content  = "www.alicloud-provider.cn"
    port     = 8898
    priority = "20"
    type     = "domain"
    weight   = 10
  }
}