variable "name" {
  default = "terraform-image-import-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_oss_bucket" "default" {
  bucket = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_oss_bucket_object" "default" {
  bucket  = alicloud_oss_bucket.default.id
  key     = "fc/hello.zip"
  content = <<EOF
    # -*- coding: utf-8 -*-
    def handler(event, context):
    print "hello world"
    return 'hello world'
    EOF
}

resource "alicloud_image_import" "default" {
  architecture = "x86_64"
  os_type      = "linux"
  platform     = "Ubuntu"
  license_type = "Auto"
  image_name   = var.name
  description  = var.name
  disk_device_mapping {
    oss_bucket      = alicloud_oss_bucket.default.id
    oss_object      = alicloud_oss_bucket_object.default.id
    disk_image_size = 5
  }
}