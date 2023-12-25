resource "alicloud_pvtz_zone" "zone" {
  zone_name = "foo.example.com"
}

resource "alicloud_vpc" "first" {
  vpc_name   = "the-first-vpc"
  cidr_block = "172.16.0.0/12"
}
resource "alicloud_vpc" "second" {
  vpc_name   = "the-second-vpc"
  cidr_block = "172.16.0.0/16"
}

provider "alicloud" {
  alias  = "eu"
  region = "eu-central-1"
}

resource "alicloud_vpc" "third" {
  provider   = alicloud.eu
  vpc_name   = "the-third-vpc"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_pvtz_zone_attachment" "zone-attachment" {
  zone_id = alicloud_pvtz_zone.zone.id
  vpcs {
    vpc_id = alicloud_vpc.first.id
  }
  vpcs {
    vpc_id = alicloud_vpc.second.id
  }
  vpcs {
    region_id = "eu-central-1"
    vpc_id    = alicloud_vpc.third.id
  }
}