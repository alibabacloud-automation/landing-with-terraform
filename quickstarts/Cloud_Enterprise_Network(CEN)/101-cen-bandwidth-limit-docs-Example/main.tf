variable "region1" {
  default = "eu-central-1"
}
variable "region2" {
  default = "ap-southeast-1"
}

provider "alicloud" {
  alias  = "ec"
  region = var.region1
}
provider "alicloud" {
  alias  = "as"
  region = var.region2
}

resource "alicloud_vpc" "vpc1" {
  provider   = alicloud.ec
  vpc_name   = "tf-example"
  cidr_block = "192.168.0.0/16"
}
resource "alicloud_vpc" "vpc2" {
  provider   = alicloud.as
  vpc_name   = "tf-example"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_cen_instance" "example" {
  cen_instance_name = "tf_example"
  description       = "an example for cen"
}
resource "alicloud_cen_instance_attachment" "example1" {
  instance_id              = alicloud_cen_instance.example.id
  child_instance_id        = alicloud_vpc.vpc1.id
  child_instance_type      = "VPC"
  child_instance_region_id = var.region1
}
resource "alicloud_cen_instance_attachment" "example2" {
  instance_id              = alicloud_cen_instance.example.id
  child_instance_id        = alicloud_vpc.vpc2.id
  child_instance_type      = "VPC"
  child_instance_region_id = var.region2
}
resource "alicloud_cen_bandwidth_package" "example" {
  bandwidth                  = 5
  cen_bandwidth_package_name = "tf_example"
  geographic_region_a_id     = "Europe"
  geographic_region_b_id     = "Asia-Pacific"
}

resource "alicloud_cen_bandwidth_package_attachment" "example" {
  instance_id          = alicloud_cen_instance.example.id
  bandwidth_package_id = alicloud_cen_bandwidth_package.example.id
}

resource "alicloud_cen_bandwidth_limit" "example" {
  instance_id     = alicloud_cen_bandwidth_package_attachment.example.instance_id
  region_ids      = [alicloud_cen_instance_attachment.example1.child_instance_region_id, alicloud_cen_instance_attachment.example2.child_instance_region_id]
  bandwidth_limit = 4
}