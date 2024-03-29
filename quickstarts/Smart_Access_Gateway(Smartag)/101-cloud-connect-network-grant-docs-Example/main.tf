variable "name" {
  default = "tf-example"
}
variable "another_uid" {
  default = 123456789
}

provider "alicloud" {
  region = "cn-shanghai"
  alias  = "default"
}

# Method 1: Use assume_role to operate resources in the target cen account, detail see https://registry.terraform.io/providers/aliyun/alicloud/latest/docs#assume-role
provider "alicloud" {
  region = "cn-hangzhou"
  alias  = "cen_account"
  assume_role {
    role_arn = "acs:ram::${var.another_uid}:role/terraform-example-assume-role"
  }
}


# Method 2: Use the target cen account's access_key, secret_key
# provider "alicloud" {
#   region     = "cn-hangzhou"
#   access_key = "access_key"
#   secret_key = "secret_key"
#   alias      = "cen_account"
# }

resource "alicloud_cloud_connect_network" "default" {
  provider    = alicloud.default
  name        = var.name
  description = var.name
  cidr_block  = "192.168.0.0/24"
  is_default  = true
}

resource "alicloud_cen_instance" "cen" {
  provider          = alicloud.cen_account
  cen_instance_name = var.name
}

resource "alicloud_cloud_connect_network_grant" "default" {
  provider = alicloud.default
  ccn_id   = alicloud_cloud_connect_network.default.id
  cen_id   = alicloud_cen_instance.cen.id
  cen_uid  = var.another_uid
}