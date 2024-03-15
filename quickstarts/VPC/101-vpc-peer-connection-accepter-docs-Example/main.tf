variable "name" {
  default = "tf-example"
}
variable "accepting_region" {
  default = "cn-beijing"
}
variable "another_uid" {
  default = "xxxx"
}
# Method 1: Use assume_role to operate resources in the target account, detail see https://registry.terraform.io/providers/aliyun/alicloud/latest/docs#assume-role
provider "alicloud" {
  region = var.accepting_region
  alias  = "accepting"
  assume_role {
    role_arn = "acs:ram::${var.another_uid}:role/terraform-example-assume-role"
  }
}

# Method 2: Use the target account's access_key, secret_key
# provider "alicloud" {
#   region     = "cn-hangzhou"
#   access_key = "access_key"
#   secret_key = "secret_key"
#   alias      = "accepting"
# }

provider "alicloud" {
  alias  = "local"
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "local" {
  provider   = alicloud.local
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vpc" "accepting" {
  provider   = alicloud.accepting
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}

data "alicloud_account" "accepting" {
  provider = alicloud.accepting
}
resource "alicloud_vpc_peer_connection" "default" {
  provider             = alicloud.local
  peer_connection_name = var.name
  vpc_id               = alicloud_vpc.local.id
  accepting_ali_uid    = data.alicloud_account.accepting.id
  accepting_region_id  = var.accepting_region
  accepting_vpc_id     = alicloud_vpc.accepting.id
  description          = var.name
}

resource "alicloud_vpc_peer_connection_accepter" "default" {
  provider    = alicloud.accepting
  instance_id = alicloud_vpc_peer_connection.default.id
}