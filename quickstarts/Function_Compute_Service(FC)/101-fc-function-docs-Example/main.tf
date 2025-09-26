provider "alicloud" {
  region = "cn-hangzhou"
}
resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_log_project" "default" {
  project_name = "example-value-${random_integer.default.result}"
}

resource "alicloud_log_store" "default" {
  project_name  = alicloud_log_project.default.project_name
  logstore_name = "example-value"
}

resource "alicloud_ram_role" "default" {
  role_name                   = "fcservicerole-${random_integer.default.result}"
  assume_role_policy_document = <<EOF
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
  EOF
  description                 = "this is a example"
  force                       = true
}

resource "alicloud_ram_role_policy_attachment" "default" {
  role_name   = alicloud_ram_role.default.role_name
  policy_name = "AliyunLogFullAccess"
  policy_type = "System"
}

resource "alicloud_fc_service" "default" {
  name        = "example-value-${random_integer.default.result}"
  description = "example-value"
  role        = alicloud_ram_role.default.arn
  log_config {
    project                 = alicloud_log_project.default.project_name
    logstore                = alicloud_log_store.default.logstore_name
    enable_instance_metrics = true
    enable_request_metrics  = true
  }
}

resource "local_file" "default" {
  content  = "import logging \ndef handler(event, context): \n  logger = logging.getLogger() \n  logger.info('hello world') \n  return 'hello world'"
  filename = "${path.module}/index.py"
}


data "archive_file" "code_package" {
  type        = "zip"
  source_file = local_file.default.filename
  output_path = "${path.module}/code.zip"
}

resource "alicloud_oss_bucket" "default" {
  bucket = "terraform-example-${random_integer.default.result}"
}
# If you upload the function by OSS Bucket, you need to specify path can't upload by content.
resource "alicloud_oss_bucket_object" "default" {
  bucket       = alicloud_oss_bucket.default.id
  key          = "index.zip"
  source       = data.archive_file.code_package.output_path
  content_type = "application/zip"
}

resource "alicloud_fc_function" "foo" {
  service     = alicloud_fc_service.default.name
  name        = "terraform-example"
  description = "example"
  oss_bucket  = alicloud_oss_bucket.default.id
  oss_key     = alicloud_oss_bucket_object.default.key
  memory_size = "512"
  runtime     = "python3.10"
  handler     = "index.handler"
  environment_variables = {
    prefix = "terraform"
  }
}