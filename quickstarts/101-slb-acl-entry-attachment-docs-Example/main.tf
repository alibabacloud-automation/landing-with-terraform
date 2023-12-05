resource "alicloud_slb_acl" "attachment" {
  name       = "forSlbAclEntryAttachment"
  ip_version = "ipv4"
}

resource "alicloud_slb_acl_entry_attachment" "attachment" {
  acl_id  = alicloud_slb_acl.attachment.id
  entry   = "168.10.10.0/24"
  comment = "second"
}
