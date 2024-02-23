variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_dbfs_instance" "example" {
  category          = "standard"
  zone_id           = "cn-hangzhou-i"
  performance_level = "PL1"
  instance_name     = var.name
  size              = 100
}