variable "name" {
  default = "terraform-example"
}


resource "alicloud_kms_application_access_point" "default" {
  description                   = "example aap"
  application_access_point_name = var.name
  policies                      = ["abc", "efg", "hfc"]
}