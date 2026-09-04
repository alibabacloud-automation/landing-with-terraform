variable "name" {
  default = "terraform-example"
}

resource "alicloud_ens_bucket_lifecycle" "default" {
  bucket_name     = "your-bucket-name"
  status          = "Enabled"
  prefix          = "logs/"
  expiration_days = 7
}