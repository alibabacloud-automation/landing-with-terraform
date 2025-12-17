variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_eflo_node_group_attachment" "default" {
  vswitch_id     = "vsw-uf63gbmvwgreao66opmie"
  hostname       = "attachment-example-e01-cn-smw4d1bzd0a"
  login_password = "G7f$2kL9@vQx3Zp5*"
  cluster_id     = "i118976621753269898628"
  node_group_id  = "i127582271753269898630"
  node_id        = "e01-cn-smw4d1bzd0a"
  vpc_id         = "vpc-uf6t73bb01dfprb2qvpqa"
}