resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_log_project" "example" {
  name        = "terraform-example-${random_integer.default.result}"
  description = "terraform-example"
  tags = {
    Created = "TF",
    For     = "example",
  }
}

resource "alicloud_log_store" "example" {
  project               = alicloud_log_project.example.name
  name                  = "example-store"
  retention_period      = 3650
  shard_count           = 3
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

resource "alicloud_log_ingestion" "example" {
  project         = alicloud_log_project.example.name
  logstore        = alicloud_log_store.example.name
  ingestion_name  = "terraform-example"
  display_name    = "terraform-example"
  description     = "terraform-example"
  interval        = "30m"
  run_immediately = true
  time_zone       = "+0800"
  source          = <<DEFINITION
        {
          "bucket": "bucket_name",
          "compressionCodec": "none",
          "encoding": "UTF-8",
          "endpoint": "oss-cn-hangzhou-internal.aliyuncs.com",
          "format": {
            "escapeChar": "\\",
            "fieldDelimiter": ",",
            "fieldNames": [],
            "firstRowAsHeader": true,
            "maxLines": 1,
            "quoteChar": "\"",
            "skipLeadingRows": 0,
            "timeField": "",
            "type": "DelimitedText"
          },
          "pattern": "",
          "prefix": "test-prefix/",
          "restoreObjectEnabled": false,
          "roleARN": "acs:ram::1049446484210612:role/aliyunlogimportossrole",
          "type": "AliyunOSS"
        }
  DEFINITION
}