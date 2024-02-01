resource "random_integer" "default" {
  min = 10000
  max = 99999
}
provider "alicloud" {
  region = "cn-hangzhou"
}
resource "alicloud_direct_mail_domain" "example" {
  domain_name = "alicloud-provider-${random_integer.default.result}.online"
}