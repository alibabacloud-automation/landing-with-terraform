variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_ebs_replica_pair_drill" "default" {
  pair_id = "pair-cn-wwo3kjfq5001"
}