provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_tag_meta_tag" "example" {
  key    = "Name1"
  values = ["Desc2"]
}