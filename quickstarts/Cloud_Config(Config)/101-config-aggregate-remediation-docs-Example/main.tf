variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_config_aggregator" "create-agg" {
  aggregator_name = "rd"
  description     = "rd"
  aggregator_type = "RD"
}

resource "alicloud_config_aggregate_config_rule" "create-rule" {
  source_owner               = "ALIYUN"
  source_identifier          = "required-tags"
  aggregate_config_rule_name = "agg-rule-name"
  config_rule_trigger_types  = "ConfigurationItemChangeNotification"
  risk_level                 = "1"
  resource_types_scope       = ["ACS::OSS::Bucket"]
  aggregator_id              = alicloud_config_aggregator.create-agg.id
  input_parameters = {
    tag1Key   = "aaa"
    tag1Value = "bbb"
  }
}


resource "alicloud_config_aggregate_remediation" "default" {
  config_rule_id          = alicloud_config_aggregate_config_rule.create-rule.config_rule_id
  remediation_template_id = "ACS-TAG-TagResources"
  remediation_source_type = "ALIYUN"
  invoke_type             = "MANUAL_EXECUTION"
  remediation_type        = "OOS"
  aggregator_id           = alicloud_config_aggregator.create-agg.id
  remediation_origin_params = jsonencode({
    properties = [
      {
        name          = "regionId"
        type          = "String"
        value         = "{regionId}"
        allowedValues = []
        description   = "region ID"
      },
      {
        name          = "tags"
        type          = "Json"
        value         = "{\"aaa\":\"bbb\"}"
        allowedValues = []
        description   = "resource tags (for example,{\"k1\":\"v1\",\"k2\":\"v2\"})."
      },
      {
        name          = "resourceType"
        type          = "String"
        value         = "{resourceType}"
        allowedValues = []
        description   = "resource type"
      },
      {
        name          = "resourceIds"
        type          = "ARRAY"
        value         = "[{\"resources\":[]}]"
        allowedValues = []
        description   = "Resource ID List"
      }
    ]
  })
}