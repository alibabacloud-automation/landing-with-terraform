resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_log_project" "example" {
  name        = "terraform-example-${random_integer.default.result}"
  description = "terraform-example"
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

resource "alicloud_logtail_config" "example" {
  project      = alicloud_log_project.example.name
  logstore     = alicloud_log_store.example.name
  input_type   = "file"
  name         = "terraform-example"
  output_type  = "LogService"
  input_detail = <<DEFINITION
  	{
		"logPath": "/logPath",
		"filePattern": "access.log",
		"logType": "json_log",
		"topicFormat": "default",
		"discardUnmatch": false,
		"enableRawLog": true,
		"fileEncoding": "gbk",
		"maxDepth": 10
	}
  DEFINITION
}