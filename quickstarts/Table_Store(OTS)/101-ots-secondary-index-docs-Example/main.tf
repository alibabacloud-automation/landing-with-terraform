variable "name" {
  default = "tf-example"
}

resource "alicloud_ots_instance" "default" {
  name        = var.name
  description = var.name
  accessed_by = "Any"
  tags = {
    Created = "TF",
    For     = "example",
  }
}

resource "alicloud_ots_table" "default" {
  instance_name = alicloud_ots_instance.default.name
  table_name    = "tf_example"
  time_to_live  = -1
  max_version   = 1
  enable_sse    = true
  sse_key_type  = "SSE_KMS_SERVICE"
  primary_key {
    name = "pk1"
    type = "Integer"
  }
  primary_key {
    name = "pk2"
    type = "String"
  }
  primary_key {
    name = "pk3"
    type = "Binary"
  }
  defined_column {
    name = "col1"
    type = "Integer"
  }
  defined_column {
    name = "col2"
    type = "String"
  }
  defined_column {
    name = "col3"
    type = "Binary"
  }
}

resource "alicloud_ots_secondary_index" "default" {
  instance_name     = alicloud_ots_instance.default.name
  table_name        = alicloud_ots_table.default.table_name
  index_name        = "example_index"
  index_type        = "Global"
  include_base_data = true
  primary_keys      = ["pk1", "pk2", "pk3"]
  defined_columns   = ["col1", "col2", "col3"]
}