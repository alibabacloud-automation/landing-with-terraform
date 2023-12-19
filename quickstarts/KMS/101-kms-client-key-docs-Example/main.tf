variable "name" {
  default = "terraform-example"
}

resource "alicloud_kms_application_access_point" "AAP0" {
  policies                      = ["aa"]
  description                   = "aa"
  application_access_point_name = var.name
}

resource "alicloud_kms_client_key" "default" {
  aap_name              = alicloud_kms_application_access_point.AAP0.application_access_point_name
  password              = "YouPassword123!"
  not_before            = "2023-09-01T14:11:22Z"
  not_after             = "2028-09-01T14:11:22Z"
  private_key_data_file = "./private_key_data_file.txt"
}