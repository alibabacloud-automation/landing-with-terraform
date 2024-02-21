variable "name" {
  default = "terraform-example"
}
resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_cddc_dedicated_host_group" "default" {
  engine                    = "MySQL"
  vpc_id                    = alicloud_vpc.default.id
  cpu_allocation_ratio      = 101
  mem_allocation_ratio      = 50
  disk_allocation_ratio     = 200
  allocation_policy         = "Evenly"
  host_replace_policy       = "Manual"
  dedicated_host_group_desc = var.name
}