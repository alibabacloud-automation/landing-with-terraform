variable "name" {
  default = "tf_example"
}
resource "alicloud_datahub_project" "example" {
  name    = var.name
  comment = "created by terraform"
}

resource "alicloud_datahub_topic" "example_blob" {
  name         = "${var.name}_blob"
  project_name = alicloud_datahub_project.example.name
  record_type  = "BLOB"
  shard_count  = 3
  life_cycle   = 7
  comment      = "created by terraform"
}

resource "alicloud_datahub_topic" "example_tuple" {
  name         = "${var.name}_tuple"
  project_name = alicloud_datahub_project.example.name
  record_type  = "TUPLE"
  record_schema = {
    bigint_field    = "BIGINT"
    timestamp_field = "TIMESTAMP"
    string_field    = "STRING"
    double_field    = "DOUBLE"
    boolean_field   = "BOOLEAN"
  }
  shard_count = 3
  life_cycle  = 7
  comment     = "created by terraform"
}