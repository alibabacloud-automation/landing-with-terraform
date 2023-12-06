data "alicloud_account" "default" {}

variable "accepting_region" {
  default = "cn-beijing"
}

provider "alicloud" {
  alias  = "local"
  region = "cn-hangzhou"
}
provider "alicloud" {
  alias  = "accepting"
  region = var.accepting_region
}

resource "alicloud_vpc" "local_vpc" {
  provider   = alicloud.local
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vpc" "accepting_vpc" {
  provider   = alicloud.accepting
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vpc_peer_connection" "default" {
  provider             = alicloud.local
  peer_connection_name = "terraform-example"
  vpc_id               = alicloud_vpc.local_vpc.id
  accepting_ali_uid    = data.alicloud_account.default.id
  accepting_region_id  = var.accepting_region
  accepting_vpc_id     = alicloud_vpc.accepting_vpc.id
  description          = "terraform-example"
}
