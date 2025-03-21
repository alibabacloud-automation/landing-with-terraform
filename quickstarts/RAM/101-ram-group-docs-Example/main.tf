variable "name" {
  default = "terraform-example"
}

resource "alicloud_ram_group" "group" {
  group_name = var.name
  comments   = var.name
  force      = true
}