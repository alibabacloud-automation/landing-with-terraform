variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "vpc_id" {
  # You need to modify this value to an existing VPC under your account
  default = "vpc-xxx"
}

variable "ecr_owner_uid" {
  # You need to modify this value to ecr owner ali uid
  default = "18xxx"
}

variable "ecr_id" {
  # You need to modify this value to an existing ecr id
  default = "ecr-xxx"
}

variable "region" {
  default = "cn-hangzhou"
}


resource "alicloud_express_connect_router_grant_association" "default" {
  ecr_id             = var.ecr_id
  instance_region_id = var.region
  instance_id        = var.vpc_id
  ecr_owner_ali_uid  = var.ecr_owner_uid
  instance_type      = "VPC"
}