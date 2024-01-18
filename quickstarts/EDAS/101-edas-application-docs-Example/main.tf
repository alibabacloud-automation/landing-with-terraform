variable "name" {
  default = "tf-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_vpc" "default" {
  vpc_name   = "${var.name}-${random_integer.default.result}"
  cidr_block = "10.4.0.0/16"
}
resource "alicloud_edas_cluster" "default" {
  cluster_name      = "${var.name}-${random_integer.default.result}"
  cluster_type      = "2"
  network_mode      = "2"
  logical_region_id = data.alicloud_regions.default.regions.0.id
  vpc_id            = alicloud_vpc.default.id
}

resource "alicloud_edas_application" "default" {
  application_name = "${var.name}-${random_integer.default.result}"
  cluster_id       = alicloud_edas_cluster.default.id
  package_type     = "JAR"
}