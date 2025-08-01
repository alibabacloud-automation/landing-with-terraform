# Before executing this example, you need to confirm with the product team whether the resources are sufficient or you will get an error message with "Failure to check order before create instance"
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_eflo_node_group_attachment" "default" {
  vswitch_id     = "vsw-xxx"
  hostname       = "attachment-example"
  login_password = "G7f$2kL9@vQx3Zp5*"
  cluster_id     = "i118976xxxx"
  node_group_id  = "i127582xxxx"
  node_id        = "e01-cn-xxxx"
  vpc_id         = "vpc-xxx"
}