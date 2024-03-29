resource "alicloud_alidns_domain_group" "default" {
  domain_group_name = "tf-example"
}
resource "alicloud_alidns_domain" "default" {
  domain_name = "starmove.com"
  group_id    = alicloud_alidns_domain_group.default.id
  tags = {
    Created = "TF",
    For     = "example",
  }
}

resource "alicloud_alidns_instance" "default" {
  dns_security   = "basic"
  domain_numbers = 3
  version_code   = "version_personal"
  period         = 1
  renewal_status = "ManualRenewal"
}

resource "alicloud_alidns_domain_attachment" "default" {
  instance_id  = alicloud_alidns_instance.default.id
  domain_names = [alicloud_alidns_domain.default.domain_name]
}