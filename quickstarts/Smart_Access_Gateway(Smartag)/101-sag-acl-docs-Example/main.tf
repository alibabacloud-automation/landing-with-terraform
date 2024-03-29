provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_sag_acl" "default" {
  name = "terraform-example"
}