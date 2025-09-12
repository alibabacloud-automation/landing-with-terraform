resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "bucket-redundancytype" {
  bucket          = "terraform-example-${random_integer.default.result}"
  redundancy_type = "ZRS"

  # ... other configuration ...
}