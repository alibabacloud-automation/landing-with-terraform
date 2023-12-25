resource "alicloud_ram_group" "default" {
  count    = "5"
  name     = "tf-example-${count.index}"
  comments = var.comments
  force    = var.force
}