resource "alicloud_slb_load_balancer" "instance" {
  load_balancer_name   = "slb_worder"
  load_balancer_spec   = "slb.s3.small"
  internet_charge_type = "PayByTraffic"
  address_type         = "internet"
}