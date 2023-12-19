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
resource "alicloud_alidns_record" "record" {
  domain_name = alicloud_alidns_domain.default.domain_name
  rr          = "alimail"
  type        = "CNAME"
  value       = "mail.mxhichin.com"
  remark      = "tf-example"
  status      = "ENABLE"
}