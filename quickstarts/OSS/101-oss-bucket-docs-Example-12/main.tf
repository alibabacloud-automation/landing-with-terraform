resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "bucket-accelerate" {
  bucket = "terraform-example-${random_integer.default.result}"

  transfer_acceleration {
    enabled = false
  }
}