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

resource "alicloud_mns_topic" "default" {
  name = "example-value-${random_integer.default.result}"
}

resource "alicloud_ram_role" "default" {
  name        = "fcservicerole-${random_integer.default.result}"
  document    = <<EOF
  {
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Principal": {
            "Service": [
              "mns.aliyuncs.com"
            ]
          }
        }
      ],
      "Version": "1"
  }
  EOF
  description = "this is a example"
  force       = true
}

resource "alicloud_ram_role_policy_attachment" "default" {
  role_name   = alicloud_ram_role.default.name
  policy_name = "AliyunMNSNotificationRolePolicy"
  policy_type = "System"
}

resource "alicloud_fc_service" "default" {
  name            = "example-value-${random_integer.default.result}"
  description     = "example-value"
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

resource "alicloud_fc_trigger" "default" {
  service    = alicloud_fc_service.default.name
  function   = alicloud_fc_function.default.name
  name       = "terraform-example"
  role       = alicloud_ram_role.default.arn
  source_arn = "acs:mns:${data.alicloud_regions.default.regions.0.id}:${data.alicloud_account.default.id}:/topics/${alicloud_mns_topic.default.name}"
  type       = "mns_topic"
  config_mns = <<EOF
  {
    "filterTag":"exampleTag",
    "notifyContentFormat":"STREAM",
    "notifyStrategy":"BACKOFF_RETRY"
  }
  EOF
}