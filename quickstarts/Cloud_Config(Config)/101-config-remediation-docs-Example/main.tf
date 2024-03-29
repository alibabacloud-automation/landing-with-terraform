variable "name" {
  default = "tf-example-oss"
}
data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_oss_bucket" "default" {
  bucket = var.name
  acl    = "public-read"
  tags = {
    For = "example"
  }
}

resource "alicloud_config_rule" "default" {
  description               = "If the ACL policy of the OSS bucket denies read access from the Internet, the configuration is considered compliant."
  source_owner              = "ALIYUN"
  source_identifier         = "oss-bucket-public-read-prohibited"
  risk_level                = 1
  tag_key_scope             = "For"
  tag_value_scope           = "example"
  region_ids_scope          = data.alicloud_regions.default.regions.0.id
  config_rule_trigger_types = "ConfigurationItemChangeNotification"
  resource_types_scope      = ["ACS::OSS::Bucket"]
  rule_name                 = "oss-bucket-public-read-prohibited"
}

resource "alicloud_config_remediation" "default" {
  config_rule_id          = alicloud_config_rule.default.config_rule_id
  remediation_template_id = "ACS-OSS-PutBucketAcl"
  remediation_source_type = "ALIYUN"
  invoke_type             = "MANUAL_EXECUTION"
  params                  = "{\"bucketName\": \"${alicloud_oss_bucket.default.bucket}\", \"regionId\": \"${data.alicloud_regions.default.regions.0.id}\", \"permissionName\": \"private\"}"
  remediation_type        = "OOS"
}