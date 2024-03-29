variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_ebs_replica_group_drill" "default" {
  group_id = "pg-m1H9aaOUIGsDUwgZ"
}