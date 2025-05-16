data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_esa_site" "default" {
  site_name   = "gositecdn-${random_integer.default.result}.cn"
  instance_id = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage    = "overseas"
  access_type = "NS"
}


resource "alicloud_esa_origin_pool" "default" {
  origins {
    type    = "OSS"
    address = "example.oss-cn-beijing.aliyuncs.com"
    header  = "{\"Host\":[\"example.oss-cn-beijing.aliyuncs.com\"]}"
    enabled = "true"
    auth_conf {
      secret_key = "<SecretKeyId>"
      auth_type  = "private_cross_account"
      access_key = "<AccessKeyId>"
    }

    weight = "50"
    name   = "origin1"
  }
  origins {
    address = "example.s3.com"
    header  = "{\"Host\": [\"example1.com\"]}"
    enabled = "true"
    auth_conf {
      version    = "v2"
      region     = "us-east-1"
      auth_type  = "private"
      access_key = "<AccessKeyId>"
      secret_key = "<SecretKeyId>"
    }

    weight = "50"
    name   = "origin2"
    type   = "S3"
  }
  origins {
    type    = "S3"
    address = "example1111.s3.com"
    header  = "{\"Host\":[\"example1111.com\"]}"
    enabled = "true"
    auth_conf {
      secret_key = "<SecretKeyId>"
      version    = "v2"
      region     = "us-east-1"
      auth_type  = "private"
      access_key = "<AccessKeyId>"
    }

    weight = "30"
    name   = "origin3"
  }

  site_id          = alicloud_esa_site.default.id
  origin_pool_name = "exampleoriginpool"
  enabled          = "true"
}