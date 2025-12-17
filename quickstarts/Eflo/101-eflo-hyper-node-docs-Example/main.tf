variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "ap-southeast-7"
}

resource "alicloud_eflo_hyper_node" "default" {
  zone_id          = "ap-southeast-7a"
  machine_type     = "efg3.GN9A.ch72"
  hpn_zone         = "A1"
  server_arch      = "bmserver"
  payment_duration = "1"
  payment_type     = "Subscription"
  stage_num        = "1"
  renewal_duration = 2
  renewal_status   = "ManualRenewal"
  tags = {
    From = "Terraform"
    Env  = "Product"
  }
}