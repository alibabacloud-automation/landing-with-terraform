resource "alicloud_pvtz_zone" "zone" {
  name = "foo.test.com"
}

resource "alicloud_pvtz_zone_record" "foo" {
  zone_id = alicloud_pvtz_zone.zone.id
  rr      = "www"
  type    = "CNAME"
  value   = "bbb.test.com"
  ttl     = 60
}