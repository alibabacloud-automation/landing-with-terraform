variable "name" {
  default = "tf-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ots_instance" "default" {
  name        = "${var.name}-${random_integer.default.result}"
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
}

resource "alicloud_ots_search_index" "default" {
  instance_name = alicloud_ots_instance.default.name
  table_name    = alicloud_ots_table.default.table_name
  index_name    = "example_index"
  time_to_live  = -1
  schema {
    field_schema {
      field_name = "col1"
      field_type = "Text"
      is_array   = false
      index      = true
      analyzer   = "Split"
      store      = true
    }
    field_schema {
      field_name          = "col2"
      field_type          = "Long"
      enable_sort_and_agg = true
    }
    field_schema {
      field_name = "pk1"
      field_type = "Long"
    }
    field_schema {
      field_name = "pk2"
      field_type = "Text"
    }

    index_setting {
      routing_fields = ["pk1", "pk2"]
    }

    index_sort {
      sorter {
        sorter_type = "PrimaryKeySort"
        order       = "Asc"
      }
      sorter {
        sorter_type = "FieldSort"
        order       = "Desc"
        field_name  = "col2"
        mode        = "Max"
      }
    }
  }
}