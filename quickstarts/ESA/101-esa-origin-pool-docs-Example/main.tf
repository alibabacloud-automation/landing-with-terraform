variable "name" {
  default = "example.site"
}

data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "default" {
  site_name   = var.name
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
      secret_key = "bd8tjba5lXxxxxiRXFIBvoCIfJIL2WJ"
      auth_type  = "private_cross_account"
      access_key = "LTAI5tGLgmPe1wFwpX8645BF"
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
      access_key = "LTAI5tGLgmPe1wFwpX8645BF"
      secret_key = "bd8tjba5lXxxxxiRXFIBvoCIfJIL2WJ"
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
      secret_key = "bd8tjba5lXxxxxiRXFIBvoCIfJIL2WJ"
      version    = "v2"
      region     = "us-east-1"
      auth_type  = "private"
      access_key = "LTAI5tGLgmPe1wFwpX8645BF"
    }

    weight = "30"
    name   = "origin3"
  }

  site_id          = alicloud_esa_site.default.id
  origin_pool_name = "exampleoriginpool"
  enabled          = "true"
}