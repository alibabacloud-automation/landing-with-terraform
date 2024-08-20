variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

resource "random_uuid" "default" {
}

resource "alicloud_oss_bucket" "default" {
  bucket = "${var.name}-${random_uuid.default.result}"
}

resource "alicloud_oss_bucket_object" "default" {
  bucket  = alicloud_oss_bucket.default.bucket
  key     = "FCV3Py39.zip"
  content = "print('hello')"
}

resource "alicloud_fcv3_function" "default" {
  description = "Create"
  memory_size = "512"
  layers = [
    "acs:fc:cn-shanghai:official:layers/Python39-Aliyun-SDK/versions/3"
  ]
  timeout   = "3"
  runtime   = "custom.debian10"
  handler   = "index.handler"
  disk_size = "512"
  custom_runtime_config {
    command = [
      "python",
      "-c",
      "example"
    ]
    args = [
      "app.py",
      "xx",
      "x"
    ]
    port = "9000"
    health_check_config {
      http_get_url          = "/ready"
      initial_delay_seconds = "1"
      period_seconds        = "10"
      success_threshold     = "1"
      timeout_seconds       = "1"
      failure_threshold     = "3"
    }

  }

  log_config {
    log_begin_rule = "None"
  }

  code {
    oss_bucket_name = alicloud_oss_bucket.default.bucket
    oss_object_name = alicloud_oss_bucket_object.default.key
    checksum        = "4270285996107335518"
  }

  instance_lifecycle_config {
    initializer {
      timeout = "1"
      handler = "index.init"
    }

    pre_stop {
      timeout = "1"
      handler = "index.stop"
    }

  }

  cpu                  = "0.5"
  instance_concurrency = "2"
  function_name        = "${var.name}-${random_uuid.default.result}"
  environment_variables = {
    "EnvKey" = "EnvVal"
  }
  internet_access = "true"
}