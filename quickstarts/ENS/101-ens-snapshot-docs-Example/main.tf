variable "name" {
  default = "terraform-example"
}

resource "alicloud_ens_disk" "disk" {
  category      = "cloud_efficiency"
  size          = "20"
  payment_type  = "PayAsYouGo"
  ens_region_id = "ch-zurich-1"
}

resource "alicloud_ens_snapshot" "default" {
  description   = var.name
  ens_region_id = "ch-zurich-1"
  snapshot_name = var.name

  disk_id = alicloud_ens_disk.disk.id
}