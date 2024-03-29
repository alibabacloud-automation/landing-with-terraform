provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_account" "default" {}

resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_cdn_domain_new" "default" {
  domain_name = "example${random_integer.default.result}.tf.com"
  cdn_type    = "web"
  scope       = "overseas"
  sources {
    content  = "1.1.1.1"
    type     = "ipaddr"
    priority = 20
    port     = 80
    weight   = 10
  }
}

resource "alicloud_fc_service" "default" {
  name            = "example-value-${random_integer.default.result}"
  description     = "example-value"
  internet_access = false
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
              "cdn.aliyuncs.com"
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

resource "alicloud_ram_policy" "default" {
  policy_name     = "fcservicepolicy-${random_integer.default.result}"
  policy_document = <<EOF
    {
        "Version": "1",
        "Statement": [
        {
            "Action": [
            "fc:InvokeFunction"
            ],
        "Resource": [
            "acs:fc:*:*:services/${alicloud_fc_service.default.name}/functions/*",
            "acs:fc:*:*:services/${alicloud_fc_service.default.name}.*/functions/*"
        ],
        "Effect": "Allow"
        }
        ]
    }
    EOF
  description     = "this is a example"
  force           = true
}
resource "alicloud_ram_role_policy_attachment" "default" {
  role_name   = alicloud_ram_role.default.name
  policy_name = alicloud_ram_policy.default.name
  policy_type = "Custom"
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
  source_arn = "acs:cdn:*:${data.alicloud_account.default.id}"
  type       = "cdn_events"
  config     = <<EOF
      {"eventName":"LogFileCreated",
     "eventVersion":"1.0.0",
     "notes":"cdn events trigger",
     "filter":{
        "domain": ["${alicloud_cdn_domain_new.default.domain_name}"]
        }
    }
EOF
}