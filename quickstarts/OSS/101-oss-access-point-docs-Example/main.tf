variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_oss_bucket" "CreateBucket" {
  storage_class = "Standard"
}


resource "alicloud_oss_access_point" "default" {
  access_point_name = var.name
  bucket            = alicloud_oss_bucket.CreateBucket.bucket
  vpc_configuration {
    vpc_id = "vpc-abcexample"
  }
  network_origin = "vpc"
  public_access_block_configuration {
    block_public_access = true
  }
}