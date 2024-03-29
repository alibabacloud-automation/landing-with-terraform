variable "name" {
  default = "terraform-example"
}
resource "alicloud_ens_key_pair" "example" {
  key_pair_name = var.name
  version       = "2017-11-10"
}