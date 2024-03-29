resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "bucket-lifecycle1" {
  bucket = "example-lifecycle1-${random_integer.default.result}"
  acl    = "public-read"

  lifecycle_rule {
    id      = "rule-days"
    prefix  = "path1/"
    enabled = true

    expiration {
      days = 365
    }
  }
  lifecycle_rule {
    id      = "rule-date"
    prefix  = "path2/"
    enabled = true

    expiration {
      date = "2018-01-12"
    }
  }
}

resource "alicloud_oss_bucket" "bucket-lifecycle2" {
  bucket = "example-lifecycle2-${random_integer.default.result}"
  acl    = "public-read"

  lifecycle_rule {
    id      = "rule-days-transition"
    prefix  = "path3/"
    enabled = true

    transitions {
      days          = "3"
      storage_class = "IA"
    }
    transitions {
      days          = "30"
      storage_class = "Archive"
    }
  }
}

resource "alicloud_oss_bucket" "bucket-lifecycle3" {
  bucket = "example-lifecycle3-${random_integer.default.result}"
  acl    = "public-read"

  lifecycle_rule {
    id      = "rule-days-transition"
    prefix  = "path3/"
    enabled = true

    transitions {
      created_before_date = "2022-11-11"
      storage_class       = "IA"
    }
    transitions {
      created_before_date = "2021-11-11"
      storage_class       = "Archive"
    }
  }
}

resource "alicloud_oss_bucket" "bucket-lifecycle4" {
  bucket = "example-lifecycle4-${random_integer.default.result}"
  acl    = "public-read"

  lifecycle_rule {
    id      = "rule-abort-multipart-upload"
    prefix  = "path3/"
    enabled = true

    abort_multipart_upload {
      days = 128
    }
  }
}

resource "alicloud_oss_bucket" "bucket-versioning-lifecycle" {
  bucket = "example-lifecycle5-${random_integer.default.result}"
  acl    = "private"

  versioning {
    status = "Enabled"
  }

  lifecycle_rule {
    id      = "rule-versioning"
    prefix  = "path1/"
    enabled = true

    expiration {
      expired_object_delete_marker = true
    }

    noncurrent_version_expiration {
      days = 240
    }

    noncurrent_version_transition {
      days          = 180
      storage_class = "Archive"
    }

    noncurrent_version_transition {
      days          = 60
      storage_class = "IA"
    }
  }
}

resource "alicloud_oss_bucket" "bucket-access-monitor-lifecycle" {
  bucket = format("example-lifecycle6-%s", random_integer.default.result)
  acl    = "private"

  access_monitor {
    status = "Enabled"
  }

  lifecycle_rule {
    id      = "rule-days-transition"
    prefix  = "path/"
    enabled = true

    transitions {
      days                     = 30
      storage_class            = "IA"
      is_access_time           = true
      return_to_std_when_visit = true
    }
  }
}

resource "alicloud_oss_bucket" "bucket-tag-lifecycle" {
  bucket = format("example-lifecycle7-%s", random_integer.default.result)
  acl    = "private"

  lifecycle_rule {
    id      = "rule-days-transition"
    prefix  = "path/"
    enabled = true
    transitions {
      created_before_date = "2022-11-11"
      storage_class       = "IA"
    }
  }

  tags = {
    Created = "TF",
    For     = "example",
  }
}