provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_ecd_custom_property" "example" {
  property_key = "example_key"
  property_values {
    property_value = "example_value"
  }
}