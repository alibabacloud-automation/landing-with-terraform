variable "another_uid" {
  default = "xxxx"
}
# Method 1: Use assume_role to operate resources in the target cen account, detail see https://registry.terraform.io/providers/aliyun/alicloud/latest/docs#assume-role
provider "alicloud" {
  region = "cn-hangzhou"
  alias  = "child_account"
  assume_role {
    role_arn = "acs:ram::${var.another_uid}:role/terraform-example-assume-role"
  }
}

# Method 2: Use the target cen account's access_key, secret_key
# provider "alicloud" {
#   region     = "cn-hangzhou"
#   access_key = "access_key"
#   secret_key = "secret_key"
#   alias      = "child_account"
# }

provider "alicloud" {
  alias = "your_account"
}
data "alicloud_account" "your_account" {
  provider = alicloud.your_account
}
data "alicloud_account" "child_account" {
  provider = alicloud.child_account
}
data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_cen_instance" "example" {
  provider          = alicloud.your_account
  cen_instance_name = "tf_example"
  description       = "an example for cen"
}

resource "alicloud_vpc" "child_account" {
  provider   = alicloud.child_account
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}
resource "alicloud_cen_instance_grant" "child_account" {
  provider          = alicloud.child_account
  cen_id            = alicloud_cen_instance.example.id
  child_instance_id = alicloud_vpc.child_account.id
  cen_owner_id      = data.alicloud_account.your_account.id
}