provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_account" "default" {}
data "alicloud_regions" "default" {
  current = true
}

resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_ram_role" "default" {
  name        = "examplerole${random_integer.default.result}"
  document    = <<DEFINITION
	{
		"Statement": [
		  {
			"Action": "sts:AssumeRole",
			"Effect": "Allow",
			"Principal": {
			  "Service": [
				"fc.aliyuncs.com"
			  ]
			}
		  }
		],
		"Version": "1"
	}
	DEFINITION
  description = "this is a example"
  force       = true
}
resource "alicloud_ram_policy" "default" {
  policy_name     = "examplepolicy${random_integer.default.result}"
  policy_document = <<DEFINITION
	{
		"Version": "1",
		"Statement": [
		  {
			"Action": "mns:*",
			"Resource": "*",
			"Effect": "Allow"
		  }
		]
	  }
	DEFINITION
}
resource "alicloud_ram_role_policy_attachment" "default" {
  role_name   = alicloud_ram_role.default.name
  policy_name = alicloud_ram_policy.default.name
  policy_type = "Custom"
}

resource "alicloud_fc_service" "default" {
  name            = "example-value-${random_integer.default.result}"
  description     = "example-value"
  role            = alicloud_ram_role.default.arn
  internet_access = false
}

resource "alicloud_oss_bucket" "default" {
  bucket = "terraform-example-${random_integer.default.result}"
}
# If you upload the function by OSS Bucket, you need to specify path can't upload by content.
resource "alicloud_oss_bucket_object" "default" {
  bucket  = alicloud_oss_bucket.default.id
  key     = "index.py"
  content = "import logging \ndef handler(event, context): \nlogger = logging.getLogger() \nlogger.info('hello world') \nreturn 'hello world'"
}

resource "alicloud_fc_function" "default" {
  service     = alicloud_fc_service.default.name
  name        = "terraform-example-${random_integer.default.result}"
  description = "example"
  oss_bucket  = alicloud_oss_bucket.default.id
  oss_key     = alicloud_oss_bucket_object.default.key
  memory_size = "512"
  runtime     = "python3.10"
  handler     = "hello.handler"
}

resource "alicloud_mns_queue" "default" {
  name = "terraform-example-${random_integer.default.result}"
}
resource "alicloud_mns_topic" "default" {
  name = "terraform-example-${random_integer.default.result}"
}

resource "alicloud_fc_function_async_invoke_config" "default" {
  service_name  = alicloud_fc_service.default.name
  function_name = alicloud_fc_function.default.name

  destination_config {
    on_failure {
      destination = "acs:mns:${data.alicloud_regions.default.regions.0.id}:${data.alicloud_account.default.id}:/queues/${alicloud_mns_queue.default.name}/messages"
    }

    on_success {
      destination = "acs:mns:${data.alicloud_regions.default.regions.0.id}:${data.alicloud_account.default.id}:/topics/${alicloud_mns_topic.default.name}/messages"
    }
  }


  # Error Handling Configuration
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 0

  # Async Job Configuration
  stateful_invocation = true

  # Configuration for Function Latest Unpublished Version
  qualifier = "LATEST"

}