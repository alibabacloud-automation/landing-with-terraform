resource "alicloud_slb_acl" "acl" {
  name       = "terraformslbaclconfig"
  ip_version = "ipv4"
}