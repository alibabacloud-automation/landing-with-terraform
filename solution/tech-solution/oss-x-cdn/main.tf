data "alicloud_cdn_service" "open_cdn" {
  enable = "On"
}

data "alicloud_oss_service" "open_oss" {
  enable = "On"
}

resource "random_integer" "default" {
  min = 100000
  max = 999999
}

resource "alicloud_oss_bucket" "oss_bucket" {
  bucket = "${var.bucket_name_prefix}-${random_integer.default.result}"
}

resource "alicloud_cdn_domain_new" "domain" {
  domain_name = "${var.domain_prefix}.${var.domain_name}"
  cdn_type    = "web"
  scope       = var.scope
  sources {
    content  = "${alicloud_oss_bucket.oss_bucket.id}.${alicloud_oss_bucket.oss_bucket.extranet_endpoint}"
    type     = "oss"
    priority = 20
    port     = 80
    weight   = 10
  }
}

resource "alicloud_cdn_domain_config" "domain_config1" {
  domain_name   = alicloud_cdn_domain_new.domain.domain_name
  function_name = "filetype_based_ttl_set"
  function_args {
    arg_name  = "file_type"
    arg_value = "jpg,png,jpeg"
  }
  function_args {
    arg_name  = "weight"
    arg_value = "99"
  }
  function_args {
    arg_name  = "ttl"
    arg_value = "2592000"
  }
}

resource "alicloud_cdn_domain_config" "domain_config2" {
  domain_name   = alicloud_cdn_domain_new.domain.domain_name
  function_name = "l2_oss_key"
  function_args {
    arg_name  = "private_oss_auth"
    arg_value = "on"
  }
  function_args {
    arg_name  = "perm_private_oss_tbl"
    arg_value = ""
  }
}

resource "alicloud_cdn_domain_config" "domain_config3" {
  domain_name   = alicloud_cdn_domain_new.domain.domain_name
  function_name = "image_transform"
  function_args {
    arg_name  = "filetype"
    arg_value = "jpeg"
  }
  function_args {
    arg_name  = "webp"
    arg_value = "off"
  }
  function_args {
    arg_name  = "orient"
    arg_value = "off"
  }
  function_args {
    arg_name  = "slim"
    arg_value = "90"
  }
  function_args {
    arg_name  = "enable"
    arg_value = "on"
  }
}

resource "alicloud_dns_record" "domain_record" {
  name        = var.domain_name
  host_record = var.domain_prefix
  type        = "CNAME"
  value       = alicloud_cdn_domain_new.domain.cname
}

# 授权CND访问OSS
data "alicloud_ram_roles" "default" {
  name_regex = local.AliyunCDNAccessingPrivateOSSRole.name
}

resource "alicloud_ram_role" "role" {
  count                       = length(data.alicloud_ram_roles.default.names) > 0 ? 0 : 1
  role_name                   = local.AliyunCDNAccessingPrivateOSSRole.name
  assume_role_policy_document = local.AliyunCDNAccessingPrivateOSSRole.document
  description                 = local.AliyunCDNAccessingPrivateOSSRole.description
}

resource "alicloud_ram_policy" "policy" {
  policy_name     = "${local.AliyunCDNAccessingPrivateOSSRolePolicy.name}-${alicloud_oss_bucket.oss_bucket.id}"
  policy_document = local.AliyunCDNAccessingPrivateOSSRolePolicy.document
  description     = local.AliyunCDNAccessingPrivateOSSRolePolicy.description
}

resource "alicloud_ram_role_policy_attachment" "attach" {
  role_name   = local.AliyunCDNAccessingPrivateOSSRole.name
  policy_name = alicloud_ram_policy.policy.policy_name
  policy_type = "Custom"

  depends_on = [alicloud_ram_role.role]
}

locals {
  AliyunCDNAccessingPrivateOSSRole = {
    name        = "AliyunCDNAccessingPrivateOSSRole"
    description = "用于CDN回源私有OSS Bucket角色的授权角色"
    document    = <<-JSON
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
    JSON
  }
  AliyunCDNAccessingPrivateOSSRolePolicy = {
    name        = "AliyunCDNAccessingPrivateOSSRolePolicy"
    description = "用于CDN回源某一私有OSS Bucket角色的授权策略，包含OSS的只读权限"
    document    = <<-JSON
    {
      "Version": "1",
      "Statement": [
        {
          "Action": [
            "oss:List*",
            "oss:Get*"
          ],
          "Resource": [
                "acs:oss:*:*:${alicloud_oss_bucket.oss_bucket.id}",
                "acs:oss:*:*:${alicloud_oss_bucket.oss_bucket.id}/*"
          ],
          "Effect": "Allow"
        }
      ]
    }
    JSON
  }
}