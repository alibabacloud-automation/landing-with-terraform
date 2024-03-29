provider "alicloud" {
  region = "cn-shanghai"
}
resource "alicloud_sag_qos" "default" {
  name = "terraform-example"
}