variable "name" {
  default = "tf-example"
}

resource "alicloud_ots_instance" "default" {
  name        = var.name
  description = var.name
  accessed_by = "Vpc"
  tags = {
    Created = "TF"
    For     = "Building table"
  }
}